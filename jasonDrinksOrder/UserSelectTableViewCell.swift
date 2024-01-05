//
//  UserSelectTableViewCell.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2024/1/1.
//

import UIKit

// CellDelegate -2- 加 UITextFieldDelegate
class UserSelectTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var cellbackgroundView: UIView!
    @IBOutlet weak var outsideGoldAlphaView: UIView!
    @IBOutlet weak var outsideGoldView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet var cupLevelButtons: [UIButton]!
    @IBOutlet var sugarLevelButtons: [UIButton]!
    @IBOutlet var iceLevelButtons: [UIButton]!
    @IBOutlet var toppingsButtons: [UIButton]!
    
    // CellDelegate -2- 加 UserSelectTableViewCellDelegate
    weak var delegate: UserSelectTableViewCellDelegate?

    
    var selectedToppingsButtons: [UIButton] = []
    var toppingsFruitButton: UIButton!  //菓玉
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        detailView.layer.cornerRadius = 8
        outsideGoldAlphaView.layer.cornerRadius = 12
        outsideGoldView.layer.cornerRadius = 10
        cellbackgroundView.layer.cornerRadius = 10
        
        toppingsFruitButton = toppingsButtons[2]
        
        // CellDelegate -3- 設定userIdTextField.delegate，追蹤使用者修改名字 UITextFieldDelegate
        userIdTextField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - UserSelectTableViewCellDelegate
    
    func userDidSelect(_ newUserId: String?) {
        delegate?.userSelected(newUserId)
    }
    
    // MARK: - UITextFieldDelegate
    // 記得加 userIdTextField.delegate = self
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 使用者輸入時，通知委託
        let newUserId = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        
        // CellDelegate -4- 使用者輸入時，通知委託 UserSelectTableViewCellDelegate
        delegate?.userSelected(newUserId)
        return true
    }
    
    // MARK: -
    func setButtonStyle(button: UIButton, titleColor: UIColor, backgroundColor: UIColor) {
        button.tintColor = backgroundColor
        
        let title = NSAttributedString(string: button.titleLabel?.text ?? "",
                                       attributes: [NSAttributedString.Key.foregroundColor: titleColor])
        
        button.setAttributedTitle(title, for: .normal)
    }
    
    
    func applyButtonStyle(button: UIButton, isSelected: Bool){
        if isSelected{
            setButtonStyle(button: button, titleColor: UIColor.white, backgroundColor: darkBlueTintColor)
            
        }else{
            setButtonStyle(button: button, titleColor: darkBlueTintColor, backgroundColor: UIColor.systemGray6)
        }
    }
    
    //主要控制菓玉的按鈕顏色
    func applyButtonStyle(button: UIButton, isEnabled: Bool){
        if isEnabled{
            setButtonStyle(button: button, titleColor: darkBlueTintColor, backgroundColor: UIColor.systemGray6)
        }else{
            setButtonStyle(button: button, titleColor: UIColor.gray, backgroundColor: UIColor.systemGray6)
        }
    }
    
    
    
    func handleSingleSelectButtonTap(selectedButton: UIButton, allButtons: [UIButton]) {
        for button in allButtons {
            // 未選中的按鈕
            applyButtonStyle(button: button, isSelected: false)
        }
        
        // 選中的按鈕
        applyButtonStyle(button: selectedButton, isSelected: true)
        
    }
    
    //配料被點選
    func handleMultiSelectButtonTap(selectedButton: UIButton){
        if selectedToppingsButtons.contains(selectedButton) {
            // 如果按鈕已經被選取，取消選擇，將按鈕設置為灰色
            applyButtonStyle(button: selectedButton, isSelected: false)
            selectedToppingsButtons.remove(at: selectedToppingsButtons.firstIndex(of: selectedButton)!)
        } else {
            // 如果按鈕未被選取，選擇它，將按鈕設置為藍色
            applyButtonStyle(button: selectedButton, isSelected: true)
            selectedToppingsButtons.append(selectedButton)
        }
    }
    
    
    //MARK: -
    @IBAction func uploadOrder(_ sender: UIButton) {
        print("func uploadOrder")
        
        if let title = sender.titleLabel?.text {
            print("\(title) Button tapped!")
            
            if let userId = userIdTextField.text{
                
                // 在發送通知時傳遞參數
                let userInfo: [String: String] = ["userId": userId]
                NotificationCenter.default.post(name: Notification.Name("handleUploadOrderButtonTapped"), object: nil, userInfo: userInfo)
            }
        }
        
    }
    
    func handleButtonTapFor(sender: UIButton,
                            buttons: [UIButton],
                           notificationName: String){
        
        // 確保按鈕有標題
        if let title = sender.titleLabel?.text,
           
            // 獲取按鈕在 buttons 陣列中的索引
            let index = buttons.firstIndex(of: sender) {
            
            // 輸出按鈕標題
            print("\(title) Button tapped!")
            
            //多選題 +白玉 +水玉 +菓玉
            if title.contains("玉") {
                print("玉")
                handleMultiSelectButtonTap(selectedButton: buttons[index])
                
            }else{
                // 單選題：設定被選中的按鈕的顏色，取消其他按鈕的選中狀態
                handleSingleSelectButtonTap(selectedButton: buttons[index], allButtons: buttons)
                print("No玉")
            }
            
            
            // 在發送通知時傳遞參數
            let userInfo: [String: String] = ["title": title]
            NotificationCenter.default.post(name: Notification.Name(notificationName), object: nil, userInfo: userInfo)
        }
    }
    
    
    @IBAction func setIceLevelButtonTapped(_ sender: UIButton) {
        print("func setIceLevel")
        
        
        if let title = sender.titleLabel?.text{
            
            //#菓玉無法做熱飲, 如果點了"熱"
            if title == IceLevel.hot99.rawValue{
                // 如果 toppingsButtons[2] 菓玉按鈕已經被選取，取消選擇，將按鈕設置為灰色
                if selectedToppingsButtons.contains(toppingsFruitButton) {
                    setToppingsButtonTapped(toppingsFruitButton)
                }
                toppingsFruitButton.isEnabled = false
                applyButtonStyle(button: toppingsFruitButton, isEnabled: false)
            }else{
                if selectedToppingsButtons.contains(toppingsFruitButton) {
                }else{
                    toppingsFruitButton.isEnabled = true
                    applyButtonStyle(button: toppingsFruitButton, isEnabled: true)
                }
            }
        }
        
        handleButtonTapFor(sender: sender, buttons: iceLevelButtons, notificationName: "handleSetIceLevelButtonTapped")
        
    }
    
    @IBAction func setCupLevelButtonTapped(_ sender: UIButton) {
        print("func setCupLevel")
        handleButtonTapFor(sender: sender, buttons: cupLevelButtons, notificationName: "handleSetCupLevelButtonTapped")
    }
    
    @IBAction func setSugarLevelButtonTapped(_ sender: UIButton) {
        print("func setSugarLevel")
        handleButtonTapFor(sender: sender, buttons: sugarLevelButtons,notificationName: "handleSetSugarLevelButtonTapped")
    }
    
    @IBAction func setToppingsButtonTapped(_ sender: UIButton) {
        print("func setToppings")
        handleButtonTapFor(sender: sender, buttons: toppingsButtons, notificationName: "handleSetToppingsButtonTapped")
    }
    
    
    
}
