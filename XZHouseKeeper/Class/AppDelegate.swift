//
//  AppDelegate.swift
//  XZHousekeeper
//
//  Created by admin on 2018/2/3.
//  Copyright © 2018年 XZ. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 设置应用程序额外信息
        setupAdditions()
        
        // 1.创建window
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        
        // 2.设置根控制器
        window?.rootViewController = XZTabBarController()
        
        // 3.让window可见
        window?.makeKeyAndVisible()
        
        return true
    }

}

// MARK: - 设置应用程序额外信息
extension AppDelegate {
    
    private func setupAdditions() {
        // 1.设置 SVProgressHUD 最小解除时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        // 2.设置网络加载指示器 - 左上角 WiFi 旁边的指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        // 3.设置用户授权显示通知
        // #available 是检测设备版本，如果是 10.0 以上
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .carPlay], completionHandler: { (success, error) in
                print("授权 " + (success ? "成功" : "失败"))
            })
        } else { // 10.0 以下
            // 取得用户授权显示通知[上方的提示条/声音/BadgeNumber]
            let notifySettings = UIUserNotificationSettings(types: [.alert, .badge, .sound,], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notifySettings)
        }
    }
    
}

