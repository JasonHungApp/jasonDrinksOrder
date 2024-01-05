//
//  MenuClassicBaseTableViewCell.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2024/1/5.
//

import UIKit

class MenuBaseTableViewCell: UITableViewCell {

    @IBOutlet weak var kimageView: UIImageView!
    @IBOutlet weak var knameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionShortLabel: UILabel!
    @IBOutlet weak var descriptionLongLabel: UILabel!

    func setImage(from url: URL) {
        kimageView.kf.setImage(with: url)
    }

}
