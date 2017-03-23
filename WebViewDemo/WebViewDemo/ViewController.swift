//
//  ViewController.swift
//  WebViewDemo
//
//  Created by 鲍的Mac on 2017/1/11.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
    }

    @IBAction func go(_ sender: Any) {
        textField.resignFirstResponder()
        let text = textField.text ?? ""
        guard let url = URL(string: text) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "param1=1&param2=2".data(using: .utf8)
        
        webView.loadRequest(request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("did start")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("did finish")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
    }
    
}
