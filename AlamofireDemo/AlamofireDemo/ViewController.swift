//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by 鲍的Mac on 2017/1/11.
//  Copyright © 2017年 YorrickBao. All rights reserved.
//

import UIKit
import Alamofire
//import PromiseKit




class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func tap(_ sender: Any) {
        fetch()
//        connect()
    }
    
    func connect() {
 
    }
    
    func fetch() {
        request("https://sapi.k780.com/?app=weather.today&weaid=101020100&appkey=23784&sign=2c37cce97f7ca38896fddc265d9aa3fa&format=json").response { (response) in
            guard let data = response.data, let str = String.init(data: data, encoding: .utf8) else { return }
            
            print(str)
        }
    }
    

}



//101020100
//https://sapi.k780.com/?app=weather.today&weaid=101020100&appkey=23784&sign=2c37cce97f7ca38896fddc265d9aa3fa&format=json
//https://sapi.k780.com/?app=weather.pm25&weaid=101020100&appkey=23784&sign=2c37cce97f7ca38896fddc265d9aa3fa&format=json
