//
//  ViewController.swift
//  TextFieldEffectsDemo
//
//  Created by YorrickBao on 2017/4/21.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//
// https://github.com/raulriera/TextFieldEffects

import UIKit
import TextFieldEffects

class ViewController: UIViewController {
    
    let textField = HoshiTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        textField.frame = CGRect(x: 0, y: 80, width: view.bounds.width, height: 60)
        textField.placeholder = "Your name"
        textField.placeholderColor = UIColor.orange
//        textField.backgroundColor = UIColor.yellow
        textField.borderActiveColor = UIColor.green
        textField.borderInactiveColor = UIColor.lightGray
        textField.placeholderFontScale = 1
        textField.textColor = UIColor.white
        
        view.addSubview(textField)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

}

