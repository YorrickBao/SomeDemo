//
//  PeripheralViewController.swift
//  BlueToothDemo
//
//  Created by 鲍的Mac on 2016/11/1.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit
import CoreBluetooth

class PeripheralViewController: UIViewController {
    
    var peripheralManager: CBPeripheralManager!
    var transferCharacteristic: CBMutableCharacteristic!
    var dataToSend: Data?
    var sendingEOM = false
    var sendDataIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Peripheral"
        
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        peripheralManager.stopAdvertising()
        super.viewWillDisappear(animated)
    }
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        if sender.isOn {
            print("switch on")
            peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [serviceUUID]])
        } else {
            print("switch off")
            peripheralManager.stopAdvertising()
        }
    }

    func sendData() {
        
        if sendingEOM {
            let didSend = peripheralManager.updateValue("EOM".data(using: .utf8)!, for: transferCharacteristic, onSubscribedCentrals: nil)
            if didSend {
                sendingEOM = false
                print("Sent: EOM")
            }
            return
        }
        
        if sendDataIndex >= (dataToSend! as NSData).length {
            return
        }
        
        var didSend = true
        
        while didSend {
            let amountToSend = min((dataToSend! as NSData).length - sendDataIndex, 20)

            let range = Range(uncheckedBounds: (lower: sendDataIndex, upper: sendDataIndex + amountToSend))
            let chunk = dataToSend!.subdata(in: range)
            didSend = peripheralManager.updateValue(chunk, for: transferCharacteristic, onSubscribedCentrals: nil)
            
            if !didSend { return }
            
            let stringFromData = String(data: chunk, encoding: .utf8)
            print("Sent: \(stringFromData)")
            
            sendDataIndex += amountToSend
            
            if sendDataIndex >= (dataToSend! as NSData).length {
                sendingEOM = true
                let eomSent = peripheralManager.updateValue("EOM".data(using: .utf8)!, for: transferCharacteristic, onSubscribedCentrals: nil)
                if eomSent {
                    sendingEOM = false
                    print("Sent: EOM")
                }
                return
            }
            
        }
    }
    

}

extension PeripheralViewController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        guard peripheral.state == .poweredOn else {return}
        print("self.peripheralManager powered on.")
        let propts = CBCharacteristicProperties.notify//.union(.write)
        let attrs = CBAttributePermissions.readable//.union(.writeable)
        transferCharacteristic = CBMutableCharacteristic(type: characteristicUUID, properties: propts, value: nil, permissions: attrs)
        let transferService = CBMutableService(type: serviceUUID, primary: true)
        transferService.characteristics = [transferCharacteristic]
        
        peripheralManager.add(transferService)
        
    }
    
//    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
//        print("did add service")
//    }
//    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
//        print("did start advertising")
//    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("Central subscribed to characteristic")
        dataToSend = "Data to send to a bluetooth connected device around your iPhone.".data(using: .utf8)
        sendDataIndex = 0
        sendData()
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        print("Central unsubscribed from characteristic")
    }
    
    func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
        sendData()
    }
}
