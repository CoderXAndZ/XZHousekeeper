//
//  XZTabBarController.swift
//  XZHousekeeper
//
//  Created by admin on 2018/2/3.
//  Copyright © 2018年 XZ. All rights reserved.
//

import UIKit
import SVProgressHUD

class XZTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建子控制器
        setupChildControllers()
        
        // 设置新特性视图
        setupNewFeatureViews()
        
        // 注册登录通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: XZUserShouldLoginNotification), object: nil)
    }
    
    /// 设置横竖屏 portrait 竖屏 landscape 横屏
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - 监听方法
    @objc private func userLogin(n:Notification) {
        print("用户登录通知 \(n)")
        
        var when = DispatchTime.now()
        
        // 判断 n.object 是否有值 -> 如果有值(token 过期)，提示用户重新登录
        if n.object != nil {
            // 设置指示器渐变样式
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "用户登录已经超时，需要重新登录")
            // 修改延迟时间
            when = DispatchTime.now() + 2
        }
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            // 指示器样式还原
            SVProgressHUD.setDefaultMaskType(.clear)
            // 展现登录控制器 - 通常会和 UINavigationController 连用，方便返回
            // FIXME: - 当修改了 token 之后，弹出授权登录页面，不登陆就返回，首页 页面 下拉的问题！！！暂未修改
//            let nav = UINavigationController.init(rootViewController: XZOAuthViewController())
//            self.present(nav, animated: true, completion: nil)
        }
    }
    
}

// MARK: - 新特性视图处理
extension XZTabBarController {
    // 设置新特性视图
    private func setupNewFeatureViews() {
        // 0. 判断是否登录
        if !XZNetworkManager.shared.userLogon {
            return
        }
        // 1.如果更新，显示新特性，否则显示欢迎
        let v = isNewVersion ? XZNewFeatureView.newFeatureView() : XZWelcomeView.welcomeView()
        // 2.添加视图
        // v.frame = view.bounds
        view.addSubview(v)
    }
    
    // extensions 中可以有计算型属性，不会占用存储空间
    /// 构造函数： 给属性分配空间
    private var isNewVersion: Bool {
        // 1.取当前的版本号 1.0.2
        let currentVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        print("当前版本 - \(currentVersion)")
        
        // 2.取保存在 ‘Document(iTunes备份)[最理想保存在用户偏好]’目录中的之前的版本号 ‘1.0.2’
        let path = NSData.getDirPath(appendPath: "version") ?? ""
        let sandboxVersion = (try? String.init(contentsOfFile: path)) ?? ""
        print("沙盒版本 - \(sandboxVersion)")
        
        // 3.将当前的版本号保存在沙盒
        try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)
        // 4.返回两个版本号‘是否一致’
        return currentVersion != sandboxVersion
        // 测试新特性
        //        return currentVersion == sandboxVersion
    }
}

// MARK: - 页面搭建
extension XZTabBarController {
    
    // 设置所有的子控制器
    private func setupChildControllers() {
        
        let jsonPath = NSData.getDirPath(appendPath: "main.json") ?? ""
        
        // 1.加载data
        var data = NSData(contentsOfFile: jsonPath)
        // 判断 data 是否有内容，如果没有，说明本地沙盒没有文件
        if data == nil {
            // 从 Bundle 中加载配置的 json
            let path = Bundle.main.path(forResource: "main", ofType: "json")
            data = NSData(contentsOfFile: path!)
        }
        
        // data 一定会有一个内容，反序列化
        // 反序列化转换成数组
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: Any]]
            else {
                return
        }
        
        var arrayVc = [UIViewController]()
        
        for i in 0..<array!.count {
            let dic = array![i]
            let vc = controller(dict: dic)
            
            arrayVc.append(vc)
        }
        
        viewControllers = arrayVc
    }
    
    /// 使用字典创建一个子控制器
    ///
    /// - Parameter dict: [clsName,clsName,imgName]
    /// - Returns: 子控制器
    private func controller(dict:[String:Any]) -> UIViewController {
        
        // 1.取得字典的值
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imgName = dict["imgName"] as? String,
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? XZBaseViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String: String]
            else {
                return UIViewController()
        }
        
        // 2.创建视图控制器
        let vc = cls.init()
        
        // 设置访客视图字典
        vc.visitorInfo = visitorDict
        
        // 3.给子控制器设置值
        vc.title = title
        vc.tabBarItem.image = UIImage.init(named: "tabbar_" + imgName)
        vc.tabBarItem.selectedImage = UIImage.init(named:  "tabbar_" + imgName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 实例化导航控制器的时候，会调用 push 方法将 rootVc 压栈
        let nav = XZNavigationController.init(rootViewController: vc)
        
        // 4.设置 tabbar 的标题字体(大小)
        vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedStringKey.foregroundColor: UIColor.orange], for: .highlighted)
        // 系统默认是 12 号字，修改字体大小，要设置 Normal 的字体大小
        vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)],for: .normal)
        
        return nav
    }

}
