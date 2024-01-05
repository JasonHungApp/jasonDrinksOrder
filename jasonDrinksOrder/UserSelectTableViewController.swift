//
//  userSelectTableViewController.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2024/1/1.
//

import UIKit

// CellDelegate -5- 加入 UserSelectTableViewCellDelegate

class UserSelectTableViewController: UITableViewController, UserSelectTableViewCellDelegate  {

    var selectedTea: Tea?
    var orderDetails: [OrderDetail] = []
    
    var toppingsWhiteButtonState = false
    var toppingsWaterButtonState = false
    var toppingsFruitButtonState = false
    
    var toppingsAmount = 0
    var cupLevelAmount = 0
    var totalAmount = 0
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNotificationCenter()
        initData()
        countTotalAmount()
        tableView.reloadData()
    }
    
    func initData(){
        if let selectedTea = selectedTea{
            print("selectedTea \(selectedTea)")
        }
        
        let teaName = selectedTea?.fields.name
        cupLevelAmount = selectedTea?.fields.priceM ?? 0
        
        // 創建一個新的 OrderDetail 物件，給預設值
        let newOrderDetail = OrderDetail(fields: OrderDetailFields(
            orderId: "彼得潘20240104",
            userId: "",
            drinkName: teaName!,
            numberOfCups: 1,  // 數量
            iceLevel: "正常冰",
            sugarLevel: "正常糖",
            cupLevel: "中杯",
            toppings: "無配料",   //白玉+水玉+菓玉
            totalAmount: totalAmount,  // 總金額
            timeStamp: generateTimeStamp(dateFormat: "yyyy/MM/dd HH:mm:ss")
        ))

        // 將新的 OrderDetail 添加到 orderDetails 陣列中
        orderDetails.append(newOrderDetail)
    }
    
    //計算總金額
    func countTotalAmount(){
        totalAmount = toppingsAmount + cupLevelAmount
        orderDetails[0].fields.totalAmount = totalAmount
    }
    
    
    // MARK: - UserSelectTableViewCellDelegate
    // CellDelegate -6- 加入 UserSelectTableViewCellDelegate function
    func userSelected(_ newUserId: String?) {
        // 在這裡處理選擇的使用者ID，並更新相對應的 OrderDetailTableViewCell
        // 使用 newUserId 更新對應的資料模型，然後更新對應的 userIdLabel
        if let newUserId {
            print("userSelected newUserId = \(newUserId)")
            orderDetails[0].fields.userId = newUserId
            
            //只更新第一個 section 的第一個 row, 不要有動畫避免閃爍
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    // MARK: - NotificationCenter
    func setNotificationCenter(){
        //送出訂單
        NotificationCenter.default.addObserver(self, selector: #selector(handleUploadOrderButtonTapped(_:)), name: Notification.Name("handleUploadOrderButtonTapped"), object: nil)
        //杯子大小
        NotificationCenter.default.addObserver(self, selector: #selector(handleSetCupLevelButtonTapped(_:)), name: Notification.Name("handleSetCupLevelButtonTapped"), object: nil)
        //糖量
        NotificationCenter.default.addObserver(self, selector: #selector(handleSetSugarLevelButtonTapped(_:)), name: Notification.Name("handleSetSugarLevelButtonTapped"), object: nil)
        //冰量
        NotificationCenter.default.addObserver(self, selector: #selector(handleSetIceLevelButtonTapped(_:)), name: Notification.Name("handleSetIceLevelButtonTapped"), object: nil)
        //配料
        NotificationCenter.default.addObserver(self, selector: #selector(handleSetToppingsButtonTapped(_:)), name: Notification.Name("handleSetToppingsButtonTapped"), object: nil)
    }
    
    
    @objc func handleUploadOrderButtonTapped(_ notification: Notification) {
        print("func handleSetCupLevelButtonTapped")
        
        if let userInfo = notification.userInfo,
           let userId = userInfo["userId"] as? String {
            print("Button tapped! userId: \(userId)")
            
            orderDetails[0].fields.timeStamp = generateTimeStamp(dateFormat: "yyyy/MM/dd HH:mm:ss")
            
            if userId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                DispatchQueue.main.async {
                    showAlertInModal(title: "訂購人空白", content: "請輸入訂購人資訊。")
                }
                return
            }
            
            orderDetails[0].fields.userId = userId
            tableView.reloadData()

            uploadOrderDataToAirtable()
        }
    }
    
    
    @objc func handleSetCupLevelButtonTapped(_ notification: Notification) {
        print("func handleSetCupLevelButtonTapped")
        if let userInfo = notification.userInfo,
           let title = userInfo["title"] as? String {
            print("Button tapped! title: \(title)")
 
            orderDetails[0].fields.cupLevel = title
            
            // 判斷是中杯，大杯
            switch title{
            case CupLevel.cupM.rawValue:
                cupLevelAmount = selectedTea?.fields.priceM ?? 0
            case CupLevel.cupL.rawValue:
                cupLevelAmount = selectedTea?.fields.priceL ?? 0
            default:
                break
            }
            
            countTotalAmount()
            
            tableView.reloadData()
            
        }
    }
    
    @objc func handleSetSugarLevelButtonTapped(_ notification: Notification) {
        print("func handleSetSugarLevelButtonTapped")
        
        if let userInfo = notification.userInfo,
           let title = userInfo["title"] as? String {
            print("Button tapped! title: \(title)")
            
            orderDetails[0].fields.sugarLevel = title
            tableView.reloadData()
        }
    }
    
    @objc func handleSetIceLevelButtonTapped(_ notification: Notification) {
        print("func handleSetIceLevelButtonTapped")
        
        if let userInfo = notification.userInfo,
           let title = userInfo["title"] as? String {
            print("Button tapped! title: \(title)")
            
            orderDetails[0].fields.iceLevel = title
            tableView.reloadData()
        }
    }
    
    @objc func handleSetToppingsButtonTapped(_ notification: Notification) {
        print("func handleSetToppingsButtonTapped")
        if let userInfo = notification.userInfo,
           let title = userInfo["title"] as? String {
            print("Button tapped! title: \(title)")
            // 在這裡可以根據按鈕類型進行相應處理
            

            
            // 判斷是那個配料按鍵被按
            switch title{
            case Toppings.white.rawValue:
                toppingsWhiteButtonState = !toppingsWhiteButtonState
            case Toppings.water.rawValue:
                toppingsWaterButtonState = !toppingsWaterButtonState
            case Toppings.fruit.rawValue:
                toppingsFruitButtonState = !toppingsFruitButtonState
            default:
                break
            }
            
            var toppings = ""
            toppingsAmount = 0
            
            if toppingsWhiteButtonState {
                toppings.append(Toppings.white.rawValue)
                toppingsAmount += 10
            }
            if toppingsWaterButtonState {
                toppings.append(Toppings.water.rawValue)
                toppingsAmount += 10

            }
            if toppingsFruitButtonState {
                toppings.append(Toppings.fruit.rawValue)
                toppingsAmount += 10

            }
            
            if toppings.isEmpty{
                toppings = "無配料"
            }
            
            orderDetails[0].fields.toppings = toppings

            countTotalAmount()
            
            tableView.reloadData()
            
        }
    }
    


    // MARK: - close
    @IBAction func close(_ sender: UIButton) {
        close()
    }
    
    func close(){
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: -
    func uploadOrderDataToAirtable() {
        print("func uploadOrderDataToAirtable")

       

        // 創建一個包含上述 OrderDetail 的 OrderDetailRecord
        let orderDetailRecord = OrderDetailRecord(records: orderDetails)

        // 呼叫上傳函數
        uploadOrderDetail(orderDetailRecord: orderDetailRecord){ [self] data in
            guard let data = data else {
                // 處理錯誤，這裡可以根據實際情況進行更多處理
                print("未獲得有效的 JSON 數據")
                DispatchQueue.main.async {
                    showAlertInModal(title: "訂單建立失敗", content: "請檢查網路後，再試一次。")
                }

                return
            }

            do {
                // 將 data 轉換為字符串印出
                if let dataString = String(data: data, encoding: .utf8) {
                    print("接收到的數據：", dataString)
                }
                
                let decodedData = try JSONDecoder().decode(OrderDetailRecord.self, from: data)
                print("OrderDetailRecord:" + "\(decodedData)")
                
                DispatchQueue.main.async {
                    showAlertInModal(title: "訂單建立成功", content: "請至團購訂單頁檢查資訊。"){
                        self.close()
                    }
                }
                
            } catch {
                print("解碼 JSON 時發生錯誤:", error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 根據 indexPath 判斷是哪個單元格，然後返回相應的高度
        if indexPath.row % 2 == 1 {
            // 返回第二個單元格的高度
            return 450.0  // 這裡替換成你需要的高度
        } else {
            // 返回第一個單元格的高度
            return 175.0   // 這裡替換成你需要的高度
        }
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 創建一個UITableViewCell
        
        var cell: UITableViewCell

        if indexPath.row % 2 == 1 {
            //下面的客製飲料設定 cell
            cell = tableView.dequeueReusableCell(withIdentifier: "UserSelectTableViewCell", for: indexPath) as! UserSelectTableViewCell
            
            if let userSelectCell = cell as? UserSelectTableViewCell {
                // CellDelegate -7- 設定 cell 的 delegate
                userSelectCell.delegate = self
             }
            
        } else {
            //上面的訂單預覽 cell
            cell = tableView.dequeueReusableCell(withIdentifier: "PreviewOrderDetailTableViewCell", for: indexPath) as! OrderDetailTableViewCell
            
            if let cell = cell as? OrderDetailTableViewCell {
                
                let orderDetail = orderDetails[indexPath.row]
                
                cell.userIdLabel.text = orderDetail.fields.userId
                cell.drinkNameLabel.text = orderDetail.fields.drinkName
                cell.timeStampLabel.text = orderDetail.fields.timeStamp
                
                cell.toppingsAmountLabel.text = "+\(toppingsAmount)"

                cell.iceLevelLabel.text = orderDetail.fields.iceLevel
                cell.sugarLevelLabel.text = orderDetail.fields.sugarLevel
                cell.cupLevelLabel.text = orderDetail.fields.cupLevel
                
                cell.cupLevelAmountLabel.text = "+\(cupLevelAmount)"
                
                if ((orderDetail.fields.toppings?.contains("玉")) != nil)  {
                    cell.toppingsLabel.text = orderDetail.fields.toppings
                }else {
                    cell.toppingsLabel.text = ""
                }
                cell.numberOfCupsLabel.text = String(orderDetail.fields.numberOfCups)+"杯"
                cell.totalAmountLabel.text = "\(totalAmount)元"
         
            }
        }

        return cell 
    }
 
}
