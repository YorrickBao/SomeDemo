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
        // Do any additional setup after loading the view, typically from a nib.
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("granted!!!")
            }
        }

        //setupLocalNotification()
        
        arrangNotification(timeInterval: 5, times: 3)
        
        center.getPendingNotificationRequests { (requests) in
            print("requests count: \(requests.count)")
            for r in requests {
                print(r.identifier)
            }
        }
    }
    
    @IBAction func button(_ sender: AnyObject) {
        center.getDeliveredNotifications { (notifications) in
            print("notification count: \(notifications.count)")
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
    
//    func setupLocalNotification() {
//        
//        let content = UNMutableNotificationContent()
//        content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
//        content.body = "This is iOS 10 new Notification Body"
//        content.sound = .default()
//        content.subtitle = "This is subtitle"
//        content.title = "This is title"
//        content.launchImageName = "launchImg"
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
//        
//        let request = UNNotificationRequest(identifier: "notificationrequestidentifier", content: content, trigger: trigger)
//        
//        let handler: (Error?) -> Void = { error in
//            if let err = error {
//                print("error::: \(err.localizedDescription)")
//            } else {
//                print("success!")
//            }
//        }
//        
//        center.add(request, withCompletionHandler: handler)
//        
//    }
    
    func arrangNotification(timeInterval: Int, times: Int) {
        DispatchQueue(label: "myQueue").async {
            for i in 0..<times {
                let content = UNMutableNotificationContent()
                content.badge = (i + 1) as NSNumber
                content.sound = .default()
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(timeInterval * (i + 1)), repeats: false)
                let request = UNNotificationRequest(identifier: "notificationrequestidentifier\(i)", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

            }
        }

    }

    
    
}

