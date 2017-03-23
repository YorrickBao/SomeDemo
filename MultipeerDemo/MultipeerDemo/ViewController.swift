//
//  ViewController.swift
//  MultipeerDemo
//
//  Created by 鲍的Mac on 2017/2/23.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var myNameTF: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var listenSwitch: UISwitch!
    
    var peerID: MCPeerID!
    var session: MCSession?
    var advs: MCAdvertiserAssistant?
    var peers = Set<MCPeerID>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
        messageTF.delegate = self
        myNameTF.delegate = self
        config(isOn: false)
        textView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
    }

    @IBAction func search(_ sender: Any) {
        peerID = MCPeerID(displayName: myNameTF.text!)
        session = MCSession(peer: peerID)
        session?.delegate = self
        let browser = MCNearbyServiceBrowser(peer: peerID, serviceType: "YorChat")
        let vc = MCBrowserViewController(browser: browser, session: session!)
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func switched(_ sender: UISwitch) {
        if sender.isOn {
            peerID = MCPeerID(displayName: myNameTF.text!)
            session = MCSession(peer: peerID)
            session?.delegate = self
            advs = MCAdvertiserAssistant(serviceType: "YorChat", discoveryInfo: nil, session: session!)
            advs?.start()
        } else {
            advs?.stop()
            advs = nil
            session = nil
        }
        config(isOn: sender.isOn)
    }
    
    func config(isOn: Bool) {
        myNameTF.isEnabled = !isOn
        searchButton.isEnabled = !isOn
        sendButton.isEnabled = isOn
        messageTF.isEnabled = isOn
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        view.endEditing(true)
        guard let data = messageTF.text?.data(using: .utf8) else { return }
        
        do {
            
            try session?.send(data, toPeers: session!.connectedPeers, with: MCSessionSendDataMode.reliable)
            textView.insertText("\n\n\(myNameTF.text!) said:\n\(messageTF.text!)")
            messageTF.text = ""
        } catch {
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func tapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
    }
}

extension ViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        config(isOn: true)
        dismiss(animated: true, completion: nil)
    }
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: MCSessionDelegate {

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            peers.insert(peerID)
        case .notConnected:
            peers.remove(peerID)
        case .connecting:
            break
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        guard let str = String(data: data, encoding: .utf8) else { return }
        DispatchQueue.main.async {
            self.textView.insertText("\n\n\(peerID.displayName) said: \n\(str)")
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        
    }
}
