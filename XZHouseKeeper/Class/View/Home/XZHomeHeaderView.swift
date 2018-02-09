//
//  XZHomeHeaderView.swift
//  XZHouseKeeper
//
//  Created by admin on 2018/2/7.
//  Copyright © 2018年 XZ. All rights reserved.
//  首页头部分类

import UIKit

class XZHomeHeaderView: UIView {
    /// 按钮点击事件回调
    var blockClickButton: ((_ btnTag: Int)->())?
    
    class func homeHeaderView() -> XZHomeHeaderView {
        
        let nib = UINib(nibName: "XZHomeHeaderView", bundle: nil)
        
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! XZHomeHeaderView
        
        return view
    }
    
    /// 点击分类按钮
    @IBAction func clickCategoryBtn(_ sender: UIButton) {
        /// 当前不是分类按钮的时候改变布局
        isCategory ? () : changeLeftCons(toItem: btnCategory)
        
        btnRoom.isSelected = false
        isCategory = true
        
        blockClickButton?(sender.tag)
    }
    
    /// 点击房间按钮
    @IBAction func clickRoomBtn(_ sender: UIButton) {
        /// 当前不是房间按钮的时候改变布局
        isCategory ? changeLeftCons(toItem: btnRoom) : ()
        
        btnCategory.isSelected = false
        isCategory = false
        
        blockClickButton?(sender.tag)
    }
    
    /// 修改按钮的左侧约束
    func changeLeftCons(toItem: UIButton) {
        
        UIView.animate(withDuration: 0.1) {
            self.bottomLine.frame.origin.x = toItem.frame.origin.x
        }
        
        toItem.isSelected = true
    }
    
    /// 判断当前是哪个视图
    private var isCategory = true
    
    /// 分类
    @IBOutlet weak var btnCategory: UIButton!
    /// 房间
    @IBOutlet weak var btnRoom: UIButton!
    /// 底部线
    @IBOutlet weak var bottomLine: UILabel!
}

// MARK: - 设置头部
extension XZHomeHeaderView {
    
//    //
//    func setupUI() {
//
//        // 分割线
//        let line = UILabel(frame: CGRect(x: 0, y: 0, width: 1, height: 30))
//        line.center.equalTo(self.center)
//        line.backgroundColor = UIColor.lightGray
//        addSubview(line)
//
//        // 分类
//        let btnSort = UIButton(title: "分类", font: 15.0, normalColor: UIColor.darkGray, highlightedColor: UIColor.purple)
//        btnSort.addTarget(self, action: #selector(clickSortButton), for: .touchUpInside)
//        self.addConstraint(NSLayoutConstraint(
//            item: btnSort,
//            attribute: .right,
//            relatedBy: .equal,
//            toItem: line,
//            attribute: .left,
//            multiplier: 1.0,
//            constant: -30))
//        self.addConstraint(NSLayoutConstraint(item: <#T##Any#>, attribute: <#T##NSLayoutAttribute#>, relatedBy: <#T##NSLayoutRelation#>, toItem: <#T##Any?#>, attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>))
//        addSubview(btnSort)
//
//        // 房间
//        let btnRoom = UIButton(title: "房间", font: 15.0, normalColor: UIColor.darkGray, highlightedColor: UIColor.purple)
//        btnRoom.addTarget(self, action: #selector(clickSortButton), for: .touchUpInside)
//        addSubview(btnRoom)
//    }
    
    
}
