//
//  menuTableViewController.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2023/12/31.
//

import UIKit
import Kingfisher

class MenuTableViewController: UITableViewController {
   
    var teaRecord: TeaRecord?
    var category: String = ""

    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setColor()
        getMenuClassic()
    }
    

    func setColor(){
        // 設定導航列返回按鈕的標題
           let backButton = UIBarButtonItem()
           backButton.title = "目錄"
           self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        // 設定返回按鈕的顏色
        self.navigationController?.navigationBar.tintColor = goldTinitColor
        
        // 設定 UITabBar 的背景顏色
        self.tabBarController?.tabBar.barTintColor = darkBlueTintColor

        // 設定 UITabBar 中選中項目的顏色
        //self.tabBarController?.tabBar.tintColor = UIColor.yellow
        
        // 設定 UINavigationBar 的背景顏色
        self.navigationController?.navigationBar.barTintColor = darkBlueTintColor
    }

    func getMenuClassic() {
        fetchMenu { result in
            DispatchQueue.main.async {
                guard let teaRecord = result else {
                    print("Invalid result type")
                    return
                }
                
                self.teaRecord = teaRecord
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: -
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 返回你的數據源中的記錄數
        return teaRecord?.records.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell: UITableViewCell

        if indexPath.row % 2 == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "MenuRightTableViewCell", for: indexPath) as! MenuRightTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "MenuLeftTableViewCell", for: indexPath) as! MenuLeftTableViewCell
        }

        configureCell(at: indexPath, cell: cell)

        if indexPath.row == (teaRecord?.records.count)! - 1 && indexPath.row > 0 {
            loadingLabel.text = ""
        }

        return cell
    }
    
    
    
    func configureCell(at indexPath: IndexPath, cell: UITableViewCell) {
        guard let tea = teaRecord?.records[indexPath.row] else {
            return
        }

        if let rightCell = cell as? MenuBaseTableViewCell {
            // 設定cell的內容
            rightCell.knameLabel.text = tea.fields.name
            if tea.fields.hotAvailable == "true" {
                rightCell.knameLabel.text = tea.fields.name + " Ⓗ"
            }
            rightCell.priceLabel.text = "中：\(tea.fields.priceM) / 大：\(tea.fields.priceL)"
            rightCell.descriptionShortLabel.text = tea.fields.descriptionShort
            rightCell.descriptionLongLabel.text = tea.fields.descriptionLong

            // 如果存在至少一個 image
            if let firstImage = tea.fields.image.first {
                let firstThumbnail = firstImage.thumbnails.large
                let largeURL = firstThumbnail.url
                print("Large URL:", largeURL)
                
                // 設定圖片
                rightCell.setImage(from: URL(string: largeURL)!)
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueIdentifierForOddRow", sender: indexPath)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "segueIdentifierForOddRow" {
             // 如果是 "segueIdentifierForOddRow" 的 segue
             if let indexPath = sender as? IndexPath, let destinationVC = segue.destination as? UserSelectTableViewController {
                 // 取得選中的奇數行資料
                 let selectedTea = teaRecord?.records[indexPath.row]
                 destinationVC.selectedTea = selectedTea
             }
         }
     }

}
