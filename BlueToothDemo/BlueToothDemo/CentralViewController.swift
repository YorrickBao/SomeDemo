//
//  CentralViewController.swift
//  BlueToothDemo
//
//  Created by 鲍的Mac on 2016/11/1.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit
import CoreBluetooth

class CentralViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var centralManager: CBCentralManager!
    var discoveredPeripheral: CBPeripheral?
    var data: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Central"
        textView.text = ""
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        centralManager.stopScan()
        print("Scanning stopped")
        super.viewWillDisappear(animated)
    }
    
    func scan() {
        centralManager.scanForPeripherals(withServices: [serviceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        print("Scaning started")
    }
    
    func cleanup() {
        guard discoveredPeripheral?.state == CBPeripheralState.connected else { return }
        if let services = discoveredPeripheral?.services {
            for service in services {
                if let chsts = service.characteristics {
                    for chst in chsts {
                        if chst.uuid.uuidString == characteristicUUID.uuidString {
                            if chst.isNotifying {
                                discoveredPeripheral?.setNotifyValue(false, for: chst)
                                return
                            }
                        }
                    }
                }
            }
        }
        centralManager.cancelPeripheralConnection(discoveredPeripheral!)
    }
    
}

extension CentralViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard central.state == .poweredOn else { return }
        scan()
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if RSSI.intValue > -15 { return }
        if RSSI.intValue < -35 { return }
        print("Discovered \(peripheral.name) at \(RSSI)")
        
        if discoveredPeripheral != peripheral {
            discoveredPeripheral = peripheral
            print("Connecting to peripheral \(peripheral)")
            centralManager.connect(peripheral, options: nil)
        }
    }
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect to \(peripheral). \(error?.localizedDescription)")
        cleanup()
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Peripheral connected")
        centralManager.stopScan()
        print("Scanning stopped")
        data = Data()
        peripheral.delegate = self
        peripheral.discoverServices([serviceUUID])
    }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Peripheral Disconnected")
        discoveredPeripheral = nil
        scan()
    }
}

extension CentralViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let err = error {
            print("Error discovering services:  \(err.localizedDescription)")
            cleanup()
            return
        }
        
        for service in peripheral.services! {
            peripheral.discoverCharacteristics([characteristicUUID], for: service)
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let err = error {
            print("Error discovering characteristics:  \(err.localizedDescription)")
            cleanup()
            return
        }
        for chst in service.characteristics! {
            if chst.uuid.uuidString == characteristicUUID.uuidString {
                peripheral.setNotifyValue(true, for: chst)
            }
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let err = error {
            print("Error discovering characteristics: \(err.localizedDescription)")
            return
        }
        let stringFromData = String(data: characteristic.value!, encoding: .utf8)
        if stringFromData == "EOM" {
            textView.text = String(data: data!, encoding: .utf8)
            peripheral.setNotifyValue(false, for: characteristic)
            centralManager.cancelPeripheralConnection(peripheral)
        }
        data?.append(characteristic.value!)
        print("Received: \(stringFromData)")

    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if let err = error {
            print("Error changing notification state: \(err.localizedDescription)")
        }
        if characteristic.uuid.uuidString == characteristicUUID.uuidString {
            return
        }
        if characteristic.isNotifying {
            print("Notification began on \(characteristic)")
        } else {
            print("Notification stopped on \(characteristic).  Disconnecting")
            centralManager.cancelPeripheralConnection(peripheral)
        }
        
        
    }
}


