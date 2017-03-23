//
//  AppDelegate.swift
//  LocalNotificationDemo
//
//  Created by 鲍的Mac on 2016/10/17.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let notificationHandler = NotificationHandler()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        
        application.applicationIconBadgeNumber = 0
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        center.delegate = notificationHandler
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("granted: \(granted)")
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {}
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {}

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("application performFetchWithCompletionHandler")
        
        let url = URL(string:"http://api.k780.com:88/?app=life.time&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")!
        //创建请求对象
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            if error != nil{
                
                //让OS知道获取数据失败
                completionHandler(UIBackgroundFetchResult.failed)
            } else {
                let str = String(data: data!, encoding: .utf8)
                print("开始", str!)
                
                let unContent = UNMutableNotificationContent()
                unContent.title = "I am title"
                unContent.subtitle = "I am subtitle"
                unContent.body = "I am body"
                unContent.badge = 666
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
                
                let unRequest = UNNotificationRequest(identifier: "testing123", content: unContent, trigger: trigger)
                UNUserNotificationCenter.current().add(unRequest, withCompletionHandler: { (error) in
                    print("register notification error: \(error)")
                })
                
                
                //让OS知道已经获取到新数据
                completionHandler(UIBackgroundFetchResult.newData)
                //completionHandler(UIBackgroundFetchResult.NoData)
            }
        }
        
        //使用resume方法启动任务
        dataTask.resume()
    }
}

