//
//  menuKindViewController.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2023/12/31.
//

import UIKit

class MenuKindViewController: UIViewController {
    @IBOutlet weak var classicButton: UIButton!
    
    @IBOutlet weak var seasonalButton: UIButton!
    
    @IBOutlet weak var mixTeaButton: UIButton!
    
    @IBOutlet weak var creamTeaButton: UIButton!
    
    @IBOutlet weak var milkTeaButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeButtonTitle(seasonalButton, fontName: "Helvetica", fontSize: 18)
        customizeButtonTitle(classicButton, fontName: "Helvetica Bold", fontSize: 28)
        customizeButtonTitle(mixTeaButton, fontName: "Helvetica", fontSize: 18)
        customizeButtonTitle(creamTeaButton, fontName: "Helvetica", fontSize: 18)
        customizeButtonTitle(milkTeaButton, fontName: "Helvetica", fontSize: 18)

    }
    
    //Helvetica Bold,Helvetica
    // https://developer.apple.com/forums/thread/699812
    func customizeButtonTitle(_ button: UIButton, fontName: String, fontSize: CGFloat) {
        if let attrFont = UIFont(name: fontName, size: fontSize) {
            let title = button.titleLabel!.text!
            let attrTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: attrFont])
            button.setAttributedTitle(attrTitle, for: .normal)
            button.titleLabel?.textAlignment = .center
        }
    }
    

    @IBAction func noDataYet(_ sender: UIButton) {
        showAlert(viewController: self, title: "資料建立中", content: "請選單品茶。")
    }
    

    

}
