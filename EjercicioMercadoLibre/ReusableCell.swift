//
//  ReusableCell.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 27/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import UIKit
import YYWebImage

class ReusableCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithPaymentMethod(paymentMethod: PaymentMethod) {
        self.titleLabel.text = paymentMethod.name

        if let imageURL = NSURL(string: paymentMethod.thumbnail) {
            self.iconImageView.yy_setImageWithURL(imageURL, options: .Progressive)
        }
    }
    
    func configureWithBank(bank: Bank) {
        self.titleLabel.text = bank.name
        
        if let imageURL = NSURL(string: bank.thumbnail) {
            self.iconImageView.yy_setImageWithURL(imageURL, options: .Progressive)
        }
    }
}
