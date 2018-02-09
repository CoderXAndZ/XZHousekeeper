//
//  XZHomeTableCell.swift
//  XZHouseKeeper
//
//  Created by admin on 2018/2/9.
//  Copyright © 2018年 XZ. All rights reserved.
//

import UIKit

class XZHomeTableCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
//        selectionStyle = UITableViewCellSelectionStyle.none
        
//        contentView.backgroundColor = UIColor(hex: 0xF6F6F6)
    }

}

// MARK: - 设置页面
extension XZHomeTableCell {
    
    func setupHomeTableCell() {
        
    }
    
}
