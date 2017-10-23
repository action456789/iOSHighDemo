//
//  AppDelegate.swift
//  UserNotificationDemo
//
//  Created by sen.ke on 2017/9/22.
//  Copyright © 2017年 sen.ke. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 使得 App 在前台也有显示通知的能力
        // 1. 设置代理
        UNUserNotificationCenter.current().delegate = self
        
        // 点击通知进入
        if let launchOptions = launchOptions, let remoteNotificationKey = launchOptions[.remoteNotification] {
            print(remoteNotificationKey)
        }
        
        
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // 2. 实现代理方法
    // 收到通知时调用
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(#function)
        completionHandler(.alert)
    }
    
    // 点击通知栏进入app时调用
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print(#function)
        print(response.notification.request.identifier)
        completionHandler()
    }
}

