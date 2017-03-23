//
//  ViewController.swift
//  LocalNotificationDemo
//
//  Created by 鲍的Mac on 2016/10/17.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func button(_ sender: AnyObject) {
        center.getDeliveredNotifications { (notifications) in
            print("getDeliveredNotifications count: \(notifications.count)")
            for n in notifications {
                print(n.request.identifier)
            }
        }
        
        DispatchQueue(label: "myQueue").async {
            UNUserNotificationCenter.current().getDeliveredNotifications { (notifications) in
                print("global queue, notification count: \(notifications.count)")
                for n in notifications {
                    print(n.request.identifier)
                }
            }
        }
        
    
    }
    

    
    func arrangNotification(timeInterval: Int, times: Int) {
        DispatchQueue(label: "myQueue").async {
            for i in 0..<times {
                let content = UNMutableNotificationContent()
                content.badge = (i + 1) as NSNumber
                content.sound = .default()
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(timeInterval * (i + 1)), repeats: true)
                let request = UNNotificationRequest(identifier: "notificationrequestidentifier\(i)", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

            }
        }

    }
    
    func arrangeRepeatedNotification() {
        let content = UNMutableNotificationContent()
        content.badge = 99 as NSNumber
        content.sound = .default()
        content.body = "notification body"
        content.subtitle = "subtitle"
        content.title = "title"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: "repeatedrequest", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    
    
}

