//
//  OrderDetailTableViewController.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2023/12/31.
//

import UIKit

class OrderDetailTableViewController: UITableViewController{
    
    var orderDetails: [OrderDetail] = []
    
    // 這裡的日期格式需要與 JSON 中的日期格式相符
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter
    }()

    // 根據日期進行分組
        /* var groupedOrders = [
             "2022/01/01": [orderDetail1, orderDetail2],
             "2022/01/02": [orderDetail3, orderDetail4, orderDetail5],
             "2022/01/03": [orderDetail6]
           ] */
    var groupedOrders: [String: [OrderDetail]] = [:]

    
    //存放分組的日期 ["2024/01/03", "2024/01/02", "2024/01/01"]
    var uniqueDates: [String] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        // 設定 UITabBar 的背景顏色
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 10/255, green: 62/255, blue: 81/255, alpha: 1.0)

        // 設定 UITabBar 中選中項目的顏色
        //self.tabBarController?.tabBar.tintColor = UIColor.yellow
        
        // 設定 UINavigationBar 的背景顏色
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 10/255, green: 62/255, blue: 81/255, alpha: 1.0)
        
        //getOrderDetail()
        
    }
    
    

    
    // MARK: -
    func getOrderDetail() {
        fetchOrderDetail { result in
            DispatchQueue.main.async {
                guard let orderDetailRecord = result else {
                    print("Invalid result type")
                    return
                }
                
                self.orderDetails = orderDetailRecord
                
                // 將資料進行分組
                self.groupData()
                
                self.tableView.reloadData()
                
                
                
            }
        }
    }
    
    func groupData() {
        
        //初始化資料
        groupedOrders = [:]
        uniqueDates = []
        
        // 迭代訂單詳細資料
        for orderDetail in orderDetails {
            // 從訂單詳細資料中獲取時間戳記
            let timestamp = orderDetail.fields.timeStamp
            
            
            // 如果成功將時間戳記轉換為日期
            if let date = dateFormatter.date(from: timestamp) {
                // 將日期格式化為字串
                let formattedDate = dateFormatter.string(from: date)
                
                
                
                // 提取日期部分作為分組鍵

                if let dateOnly = dateFormatter.date(from: formattedDate) {
                    // 使用另一個日期格式化器僅提取日期部分
                    let dateOnlyFormatter = DateFormatter()
                    dateOnlyFormatter.dateFormat = "yyyy/MM/dd"
                    let formattedDateOnly = dateOnlyFormatter.string(from: dateOnly)
                    print("formattedDateOnly = \(formattedDateOnly)")


                    if groupedOrders[formattedDateOnly] == nil {
                        groupedOrders[formattedDateOnly] = []
                    }

                    // 如果該日期尚未在分組訂單中建立，則初始化一個空的陣列
                    groupedOrders[formattedDateOnly]?.append(orderDetail)
                    
                    /*
                     var groupedOrders = [
                         "2022/01/01": [orderDetail1, orderDetail2],
                         "2022/01/02": [orderDetail3, orderDetail4, orderDetail5],
                         "2022/01/03": [orderDetail6]
                     ]
                     
                     */
                }
            } else {
                // 如果無法解析時間戳記，則輸出錯誤訊息
                print("Error: Failed to parse timestamp for orderDetail: \(orderDetail.fields.timeStamp)")
            }
        }
        
        print("groupedOrders = ")
        print(groupedOrders)
        
        /*
         groupedOrders =
         [
        "2024/01/01": [
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Sunny_888", drinkName: "麗春紅茶", numberOfCups: 1, iceLevel: "少冰", sugarLevel: "半糖", cupLevel: "大杯", toppings: Optional("+白玉+菓玉"), totalAmount: 60, timeStamp: "2024/01/01 10:36:33")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Jenny_456", drinkName: "金蜜紅茶", numberOfCups: 1, iceLevel: "熱", sugarLevel: "半糖", cupLevel: "中杯", toppings: nil, totalAmount: 70, timeStamp: "2024/01/01 09:22:41")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "jason_123", drinkName: "熟成紅茶", numberOfCups: 2, iceLevel: "少冰", sugarLevel: "半糖", cupLevel: "大杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 80, timeStamp: "2024/01/01 11:41:23")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "jason_123", drinkName: "熟成紅茶", numberOfCups: 1, iceLevel: "少冰", sugarLevel: "半糖", cupLevel: "大杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 70, timeStamp: "2024/01/01 10:33:49")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Jason_123", drinkName: "熟成紅茶", numberOfCups: 1, iceLevel: "少冰", sugarLevel: "半糖", cupLevel: "大杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 70, timeStamp: "2024/01/01 08:33:49")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Mary_554", drinkName: "金蜜紅茶", numberOfCups: 1, iceLevel: "少冰", sugarLevel: "半糖", cupLevel: "大杯", toppings: nil, totalAmount: 80, timeStamp: "2024/01/01 10:33:56"))],
         "2024/01/02": [
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Jason-897", drinkName: "麗春紅茶", numberOfCups: 1, iceLevel: "少冰", sugarLevel: "二分糖", cupLevel: "大杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 50, timeStamp: "2024/01/02 04:43:04")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Jason Hung-250", drinkName: "熟成冷露", numberOfCups: 1, iceLevel: "溫", sugarLevel: "一分糖", cupLevel: "大杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 65, timeStamp: "2024/01/02 22:09:07")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Jason Hung", drinkName: "麗春紅茶", numberOfCups: 1, iceLevel: "正常冰", sugarLevel: "二分糖", cupLevel: "中杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 65, timeStamp: "2024/01/02 22:55:57")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Jason Hung7", drinkName: "麗春紅茶", numberOfCups: 1, iceLevel: "去冰", sugarLevel: "微糖", cupLevel: "中杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 65, timeStamp: "2024/01/02 22:24:32")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Jason Hung", drinkName: "麗春紅茶", numberOfCups: 1, iceLevel: "正常冰", sugarLevel: "正常糖", cupLevel: "中杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 65, timeStamp: "2024/01/02 22:44:32")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Jason Hung7", drinkName: "麗春紅茶", numberOfCups: 1, iceLevel: "去冰", sugarLevel: "微糖", cupLevel: "中杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 65, timeStamp: "2024/01/02 22:26:08")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Jason-125", drinkName: "麗春紅茶", numberOfCups: 1, iceLevel: "少冰", sugarLevel: "二分糖", cupLevel: "大杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 50, timeStamp: "2024/01/02 04:43:02"))],
         "2024/01/03": [
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Jason Hung555", drinkName: "麗春紅茶", numberOfCups: 1, iceLevel: "正常冰", sugarLevel: "二分糖", cupLevel: "大杯", toppings: Optional("+水玉+菓玉"), totalAmount: 60, timeStamp: "2024/01/03 15:23:23")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "JasonHung", drinkName: "麗春紅茶", numberOfCups: 1, iceLevel: "常溫", sugarLevel: "一分糖", cupLevel: "中杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 35, timeStamp: "2024/01/03 15:16:17")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Jason Hung", drinkName: "麗春紅茶", numberOfCups: 1, iceLevel: "溫", sugarLevel: "正常糖", cupLevel: "大杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 65, timeStamp: "2024/01/03 13:44:36")),
                        jasonDrinksOrder.OrderDetail(fields: jasonDrinksOrder.OrderDetailFields(orderId: "彼得潘20240104", userId: "Jason Hung999", drinkName: "麗春紅茶", numberOfCups: 1, iceLevel: "溫", sugarLevel: "無糖", cupLevel: "大杯", toppings: Optional("+白玉+水玉+菓玉"), totalAmount: 70, timeStamp: "2024/01/03 15:24:20"))]]
         
         
         */
        
        
        
        

        // 設定 uniqueDates，將分組訂單的日期鍵排序後儲存
        //uniqueDates = Array(groupedOrders.keys).sorted()     //uniqueDates = ["2024/01/01", "2024/01/02", "2024/01/03"]
        uniqueDates = Array(groupedOrders.keys).sorted(by: { $0 > $1 }) //反向排序 //uniqueDates = ["2024/01/03", "2024/01/02", "2024/01/01"]

        print("uniqueDates = \(uniqueDates)")
         

        
        
    }
    

    // MARK: - Table view data source
    
    // 當視圖即將出現時被呼叫
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("OrderDetailTableViewController - viewWillAppear")
        getOrderDetail()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // 計算區段數量
        let numberOfSections = uniqueDates.count
        print("\n numberOfSections = \(numberOfSections)")
        //numberOfSections = 3
        
        return numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return uniqueDates[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("numberOfRowsInSection section = \(section)")

        guard let orderDetails = groupedOrders[uniqueDates[section]], !orderDetails.isEmpty else {
            print("groupedOrders[uniqueDates[section]] is nil or empty")
            return 0
        }
        
        print("return orderDetails.count = \(orderDetails.count)")
        
        /*
         numberOfRowsInSection section = 2
         return orderDetails.count = 6
         numberOfRowsInSection section = 0
         return orderDetails.count = 4
         numberOfRowsInSection section = 1
         return orderDetails.count = 7
         */

        return orderDetails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailTableViewCell", for: indexPath)

        // 從重用池獲得一個 ListTableViewCell 實例
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailTableViewCell", for: indexPath) as? OrderDetailTableViewCell
        // 獲取對應的訂單數據
        
        
        let date = Array(uniqueDates)[indexPath.section]
        
        
        if let orderDetails = groupedOrders[date] {
            let sortedOrderDetails = orderDetails.sorted(by: { $0.fields.timeStamp > $1.fields.timeStamp })
            
            if let orderDetail = sortedOrderDetails[safe: indexPath.row] {
                // 在這裡使用排序後的 orderDetail
                // 在這裡設定 Cell 的內容，使用 orderDetail 中的資料
                cell?.userIdLabel.text = orderDetail.fields.userId
                cell?.drinkNameLabel.text = orderDetail.fields.drinkName
                cell?.timeStampLabel.text = orderDetail.fields.timeStamp
                

                cell?.iceLevelLabel.text = orderDetail.fields.iceLevel
                cell?.sugarLevelLabel.text = orderDetail.fields.sugarLevel
                cell?.cupLevelLabel.text = orderDetail.fields.cupLevel
                if ((orderDetail.fields.toppings?.contains("玉")) != nil)  {
                    cell?.toppingsLabel.text = orderDetail.fields.toppings
                }else {
                    cell?.toppingsLabel.text = "無配料"
                }
                cell?.numberOfCupsLabel.text = String(orderDetail.fields.numberOfCups)+"杯"
                cell?.totalAmountLabel.text = String(orderDetail.fields.totalAmount)+"元"
            }
            
            
        }
        
        return cell ?? UITableViewCell()
        
       
    }
    
    //
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = darkBlueTintColor.withAlphaComponent(0.9)

        let label = UILabel()
        label.text = uniqueDates[section]
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false

        headerView.addSubview(label)

        //auto layout
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44  // Adjust the height based on your preference
    }


    
    
    
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
