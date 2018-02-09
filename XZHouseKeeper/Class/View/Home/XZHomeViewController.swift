//
//  XZHomeViewController.swift
//  XZHousekeeper
//
//  Created by admin on 2018/2/5.
//  Copyright © 2018年 XZ. All rights reserved.
//  首页

import UIKit

private let homeTableCell = "XZHomeTableCell"
private let homeCollectionCell = "XZHomeCollectionCell"

class XZHomeViewController: XZBaseViewController {
    
    private lazy var headerView: XZHomeHeaderView = XZHomeHeaderView.homeHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置头部
        setupHeaderView()
        
        //
        setupChildView()
    }
    
    /// 左侧tableView
    private var tableView = UITableView(frame: CGRect(), style: UITableViewStyle.plain)
    /// 右侧collectionView
    private var collectionView: UICollectionView?
}

// MARK: - UICollectionViewDataSource
extension XZHomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: homeCollectionCell, for: indexPath)
        
        item.backgroundColor = UIColor(isRandom: true)
        
        return item
    }
    
}

// MARK: - UITableViewDataSource
extension XZHomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: homeTableCell, for: indexPath)
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.628021631, blue: 0.6475694444, alpha: 1)
        
        return cell
    }
}

extension XZHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        collectionView?.reloadData()
    }
    
}

// MARK: - 界面搭建
extension XZHomeViewController {
    
    func setupChildView() {
        var offset: CGFloat = 64.0
        if #available(iOS 11.0, *) {
            offset = 84.0
        }
        
        let height = UIScreen.main.xz_height - offset - 40
        let frame = CGRect(x: 0, y: offset + 40, width: 100, height: height)
        tableView.frame = frame
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: homeTableCell)
        
        /// flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        
        let width = UIScreen.main.xz_width - 100
        let itemW = width / 3.0
        
        flowLayout.itemSize = CGSize(width: itemW, height: itemW + 50)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        /// 右侧 collectionView
        collectionView = UICollectionView(frame:CGRect(x: 100, y: offset + 40, width: width, height: height), collectionViewLayout:flowLayout)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor.white
        
        view.addSubview(collectionView!)
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: homeCollectionCell)
    }
    
    func setupHeaderView() {
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(headerView)
        headerView.backgroundColor = UIColor.orange

        var offset: CGFloat = 64.0
        if #available(iOS 11.0, *) {
            offset = 84.0
        }
        
        headerView.frame = CGRect(x: 0, y: offset, width: UIScreen.main.xz_width, height: 40)
        
        /// 头部的点击事件
        headerView.blockClickButton = { [weak self] btnTag in
            
            if btnTag == 110 { // 分类
                
            }else { // 房间
                
            }
            // 刷新
            self?.collectionView?.reloadData()
        }
        
    }
}
