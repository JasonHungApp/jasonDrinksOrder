//
//  UserSelectTableViewCellDelegate.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2024/1/4.
//

import Foundation

// CellDelegate -1- 建立protocol，用來通知 tableViewController 使用者改了名字
protocol UserSelectTableViewCellDelegate: AnyObject {
    func userSelected(_ newUserId: String?)
}
