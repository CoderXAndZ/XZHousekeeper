//
//  XZNavigationController.swift
//  XZHousekeeper
//
//  Created by admin on 2018/2/5.
//  Copyright © 2018年 XZ. All rights reserved.
//

import UIKit

class XZNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        setupNavigationBar()
    }
    
//    // MARK: - 访客视图的注册/登录按钮添加点击事件
//    /// 登录
//    @objc func loginAction() {
//        print("用户登录")
//        // 发送通知
//        NotificationCenter.default.post(name:NSNotification.Name(rawValue: XZUserShouldLoginNotification), object: nil)
//    }
//
//    /// 注册
//    @objc func registerAction() {
//        print("用户注册")
//    }
    
    // 重写 push 方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            // 隐藏底部的 tabBar
            viewController.hidesBottomBarWhenPushed = true
            
            // 判断控制器的类型
            if let vc = viewController as? XZBaseViewController {
                
                var title = "返回"
                // 只有一个子控制器的时候，显示栈底控制器的标题
                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                }
                // 取出自定义的 navItem，设置左侧按钮作为返回按钮
                vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: title,target: self, action: #selector(backAction), isBack: true)
            }
            
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    /// 返回上层控制器
    @objc func backAction() {
        popViewController(animated: true)
    }
}

// MARK: - 
extension XZNavigationController {
    
    /// 设置导航条
    private func setupNavigationBar() {
        
        // 1>设置 navBar 的背景渲染颜色
        navigationBar.barTintColor = UIColor(hex: 0xF6F6F6)
        // 2>设置 navBar 的 title 颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        // 3>设置 navBar 的 BarButtonItem 文字渲染颜色
        navigationBar.tintColor = .orange
        
//        // 3.设置导航条按钮
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerAction))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginAction))
    }
    
}
