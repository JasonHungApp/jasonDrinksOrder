//
//  showAlert.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2024/1/5.
//

import Foundation
import UIKit

func showAlert(viewController: UIViewController, title: String, content: String, completion: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: content, preferredStyle: .alert)

    // 創建一個 OK 按鈕
    let okAction = UIAlertAction(title: "確定", style: .default) { _ in
        // 在這裡執行按下按鈕後的操作
        completion?()
    }

    // 將 OK 按鈕添加到 UIAlertController
    alertController.addAction(okAction)

    viewController.present(alertController, animated: false, completion: nil)
}


func showAlertInModal(title: String, content: String, completion: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: content, preferredStyle: .alert)

    // 創建一個 OK 按鈕
    let okAction = UIAlertAction(title: "確定", style: .default) { _ in
        // 在這裡執行按下按鈕後的操作
        completion?()
    }

    // 將 OK 按鈕添加到 UIAlertController
    alertController.addAction(okAction)

    // 在當前視圖控制器中顯示 UIAlertController
    if let topViewController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController {
        topViewController.present(alertController, animated: true, completion: nil)
    }
}
