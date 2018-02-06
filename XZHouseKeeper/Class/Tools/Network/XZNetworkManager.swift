//
//  XZNetworkManager.swift
//  XZSwfitWB
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 XZ. All rights reserved.
//

import UIKit
// 导入框架的文件夹名字
import AFNetworking

// Swfit 的枚举支持任意数据类型
// Switch / enum 在 OC 中都只是支持整数
enum XZHTTPMethod {
    case GET
    case POST
}

// MARK: - 封装AFN，网络管理工具
class XZNetworkManager: AFHTTPSessionManager {
    // 在第一次访问时，执行闭包，并且将结果保存在 shared 常量中
    // 设置请求的属性
    static let shared: XZNetworkManager = {
        // 实例化对象
        let instance = XZNetworkManager()
        // 设置响应反序列化支持的数据类型
      instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        // 返回对象
        return instance
    }()
    
    // 用户账户的懒加载属性
    lazy var userAccount = XZUserAccount()
    // 用户登录标记[计算型属性]
    var userLogon: Bool {
        return userAccount.access_token != nil
    }
    
    // MARK: - 封装 AFN 方法
    /// 封装 AFN 的上传文件方法
    /// 上传文件必须是 POST 方法，GET 只能获取数据
    /// - Parameters:
    ///   - URLString:  URLString
    ///   - parameters: 参数字典
    ///   - name: 接受上传数据的服务器字段(name - 跟后台定义的统一) ‘pic’
    ///   - data:       要上传的二进制数据
    ///   - completion: 完成回调
    func upload(URLString: String, parameters: [String: Any]?, name: String, data: Data, completion: @escaping (_ json:Any?, _ isSuccess: Bool)->()) {
        post(URLString, parameters: parameters, constructingBodyWith: { (formData) in
            // 创建 formData
            /**
             1.data: 要上传的二进制数据
             2.name: 服务器接收数据的字段名
             3.fileName: 保存在服务器的文件名，大多数服务器现在都可以乱写
                很多服务器，上传图片完成后，会生成缩略图，中图，大图...
             4.mimeType: 告诉服务器上传文件的类型，如果不想告诉，可以使用 appliction/octet-stream
                image/png image/jpg image/gif
             */
            formData.appendPart(withFileData: data, name: name, fileName: "pic", mimeType: "application/octet-stream")
            
        }, progress: nil, success: { (_, json) in
            
            completion(json, true)
        }, failure: { (task, error) in
            
            // 针对 403 处理用户 token 过期
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("Token 过期了")
                // 发送通知，提示用户再次登录(本方法不知道被谁调用,谁接受到通知，谁处理！)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: XZUserShouldLoginNotification), object: "bad token")
            }
            print("上传文件 - 网络请求错误 \(error)")
            
            completion(nil, false)
        })
    }
    
    /// 封装 AFN 的 GET / POST 请求
    ///
    /// - Parameters:
    ///   - method:     GET / POST
    ///   - URLString:  URLString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调[json(字典 / 数组),是否成功]
    func requst(method:XZHTTPMethod = .GET,URLString: String, parameters: [String: Any]?, completion: @escaping (_ json:Any?, _ isSuccess: Bool)->()) {
        
        // 成功回调
        let success = { (task: URLSessionDataTask, json: Any?)->() in
            completion(json, true)
        }
        // 失败回调
        let failure = { (task: URLSessionDataTask?, error: Error)->() in
            // 针对 403 处理用户 token 过期
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("Token 过期了")
                // 发送通知，提示用户再次登录(本方法不知道被谁调用,谁接受到通知，谁处理！)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: XZUserShouldLoginNotification), object: "bad token")
            }
            print("网络请求错误 \(error)")
            completion(error, false)
        }
        // 进度
        let progress = { (progress: Progress)->() in
            
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: progress, success: success, failure: failure)
        }else {
            post(URLString, parameters: parameters, progress: progress, success: success, failure: failure)
        }        
    }
}

// MARK: -
extension XZNetworkManager {
    
    
}
