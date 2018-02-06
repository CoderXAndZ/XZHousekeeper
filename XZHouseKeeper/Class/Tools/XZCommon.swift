//
//  XZCommon.swift
//  XZHousekeeper
//
//  Created by admin on 2018/2/5.
//  Copyright © 2018年 XZ. All rights reserved.
//

import Foundation


// MARK: - 全局通知定义
/// 用户需要登录通知
let XZUserShouldLoginNotification = "UserShouldLoginNotification"
/// 用户登录成功通知
let XZUserLoginSuccessedNotification = "UserLoginSuccessedNotification"


// MARK: - 照片浏览通知定义
/// @param selectedIndex    选中照片索引
/// @param urls             浏览照片 URL 字符串数组
/// @param parentImageViews 父视图的图像视图数组，用户展现和解除转场动画参照
/// 微博 Cell 浏览照片通知
let XZStatusCellBrowserPhotoNotification = "XZStatusCellBrowserPhotoNotification"
/// 选中索引 Key
let XZStatusCellBrowserPhotoSelectedIndexKey = "XZStatusCellBrowserPhotoSelectedIndexKey"
/// 浏览照片 URL 字符串 Key
let XZStatusCellBrowserPhotoURLsKey = "XZStatusCellBrowserPhotoURLsKey"
/// 父视图的图像视图数组 Key
let XZStatusCellBrowserPhotoImageViewsKey = "XZStatusCellBrowserPhotoImageViewsKey"
