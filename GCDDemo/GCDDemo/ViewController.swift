//
//  ViewController.swift
//  GCDDemo
//
//  Created by 鲍的Mac on 2016/12/29.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let semaphore = DispatchSemaphore(value: 1)
    
    @IBOutlet weak var label: UILabel!
    
    var a = 0
//        {
//        didSet {
//            semaphore.wait()
//            label.text = "\(a)"
//            semaphore.signal()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let semaphore = DispatchSemaphore(value: 0)
        print("start")
        DispatchQueue.global().async {
            print("pre sleep")
            sleep(3)
            print("post sleep")
            DispatchQueue.main.async {
                DispatchQueue.global().async {
                    semaphore.signal()
                }
                
            }
            
        }
        semaphore.wait()
        print("end")
    }
    @IBAction func dispatchGroup(_ sender: UIButton) {
        let group = DispatchGroup()
        let queue1 = DispatchQueue(label: "queue1")
        let queue2 = DispatchQueue(label: "queue2")
        group.enter()
        queue1.async {
            
            for _ in 0..<10_000_000 {
                var a = 1
                a += 1
            }
            
            print("queue1 end")
            group.leave()
        }
        
        group.enter()
        queue2.async {
            
            for _ in 0..<100 {
                var a = 1
                a += 1
            }
            
            print("queue2 end")
            group.leave()
        }
        
        group.notify(queue: .main) { 
            print("complete!")
        }
        
        
        
        
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var count = 0
        
        
        let group = DispatchGroup()
        let queue1 = DispatchQueue(label: "queue1")
        let queue2 = DispatchQueue(label: "queue2")
        let queue3 = DispatchQueue(label: "queue3")
        
        queue1.async(group: group) {
            
            for _ in 0..<1000000 {
                self.semaphore.wait()
                count += 1
                self.semaphore.signal()
            }
            
            print("queue1 end")
        }
        
        queue2.async(group: group) {
            
            for _ in 0..<1000000 {
                self.semaphore.wait()
                count += 1
                self.semaphore.signal()
            }
            
            print("queue2 end")
        }
        
        queue3.async(group: group) {
            for _ in 0..<1000000 {
                self.semaphore.wait()
                self.a = count
                self.semaphore.signal()
            }
        }
        
        group.notify(queue: .main) {
            print(count)
        }
    }
}

