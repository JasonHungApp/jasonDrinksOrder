//
//  OrderDetailTableViewCell.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2023/12/31.
//

import UIKit



class OrderDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var drinkNameLabel: UILabel!
    
    @IBOutlet weak var toppingsLabel: UILabel!
    
    @IBOutlet weak var toppingsAmountLabel: UILabel!
    @IBOutlet weak var cupLevelLabel: UILabel!
    
    @IBOutlet weak var cupLevelAmountLabel: UILabel!
    @IBOutlet weak var sugarLevelLabel: UILabel!
    
    @IBOutlet weak var iceLevelLabel: UILabel!
    
    @IBOutlet weak var numberOfCupsLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var outsideGoldAlphaView: UIView!
    
    @IBOutlet weak var outsideGoldView: UIView!
    @IBOutlet weak var cellbackgroundView: UIView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        detailView.layer.cornerRadius = 8
        outsideGoldAlphaView.layer.cornerRadius = 12
        outsideGoldView.layer.cornerRadius = 10
        cellbackgroundView.layer.cornerRadius = 10

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
