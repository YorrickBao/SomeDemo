//
//  Brain.swift
//  MultipeerDemo
//
//  Created by 鲍的Mac on 2017/2/23.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Brain {
    
    var name: String
    var age: Int
    
    func connect() {
        
    }
    
    func encode() -> Data? {
        let coder = NSCoder()
        coder.encode(age, forKey: "age")
        coder.encode(name, forKey: "name")
        return coder.decodeData()
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
}
