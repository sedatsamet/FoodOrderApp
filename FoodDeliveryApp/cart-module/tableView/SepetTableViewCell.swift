//
//  SepetTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 19.10.2022.
//

import UIKit

class SepetTableViewCell: UITableViewCell {

    @IBOutlet weak var sepetYemekAdiLabel: UILabel!
    @IBOutlet weak var sepetYemekFiyatLabel: UILabel!
    @IBOutlet weak var sepetYemekImageView: UIImageView!
    @IBOutlet weak var adetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
