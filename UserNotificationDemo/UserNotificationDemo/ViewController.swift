//
//  ViewController.swift
//  UserNotificationDemo
//
//  Created by sen.ke on 2017/9/22.
//  Copyright © 2017年 sen.ke. All rights reserved.
//  iOS 10 通知中心
//  https://chengwey.com/ios-10-by-tutorials-bi-ji-ba/

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 本地通知
        // 1. 请求权限
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("已授权推送通知")
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
        
        // 2. 添加通知内容
        let content = UNMutableNotificationContent()
        content.title = "New cuddlePix!"
        content.subtitle = "What a treat"
        content.body = "Cheer yourself up with a hug ) " //TODO: Add attachment
        
        // 添加多媒体附件
        // The URL must be a file URL
        let path = Bundle.main.path(forResource: "新垣结衣.jpg", ofType: nil)
        let imageURL = URL(fileURLWithPath: path!)
        let attatchment = try! UNNotificationAttachment(identifier: "attatchment", url: imageURL, options: .none)
        content.attachments = [attatchment]
        
        // 如果重复，timeInterval 要 >= 60
        // repeats = false 时，表示延迟 timeInterval 秒触发
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let identifier = NSDate().timeIntervalSince1970
        let request = UNNotificationRequest(identifier: String(identifier), content: content, trigger: trigger)
        
        // 3. 发送通知
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error)
            } else {
                print("已发送通知")
            }
        }
        
        // 读取应用的通知设置状态
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            self.loadNotificationDFata()
        }
    }

    func loadNotificationDFata() {
        // 获取通知的设置
        UNUserNotificationCenter.current().getNotificationSettings { (setting) in
            print("getNotificationSettings:", setting.soundSetting)
        }
        
        // 获取挂起的通知
        UNUserNotificationCenter.current().getPendingNotificationRequests { (request) in
            print("getPendingNotificationRequests:", request.count)
        }
        
        // 获取已发送的通知
        UNUserNotificationCenter.current().getDeliveredNotifications { (notification) in
            print("getDeliveredNotifications:", notification.count)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

