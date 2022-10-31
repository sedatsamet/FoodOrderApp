//
//  MenuTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 18.10.2022.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekAdLabel: UILabel!
    @IBOutlet weak var yemekDetayLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
