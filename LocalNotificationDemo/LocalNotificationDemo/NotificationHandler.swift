//
//  NotificationHandler.swift
//  LocalNotificationDemo
//
//  Created by 鲍的Mac on 2016/10/17.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UserNotifications

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("userNotificationCenter willPresent")
        
        completionHandler([.sound, .alert])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("userNotificationCenter didReceive")
        
        if let name = response.notification.request.content.userInfo["name"] as? String {
            print("I know it's you! \(name)")
        }
        
        completionHandler()
        
    }

    
}
