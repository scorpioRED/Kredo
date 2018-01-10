//
//  CardsListTableViewCell.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/5/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import UIKit

class CardsListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var loaderView: UIView!
    
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var cardBalance: UILabel!
    
    @IBOutlet weak var cardCurrencu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 10
        self.bgView.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.bgView.layer.borderWidth = 0.5
        //        cell.layer.cornerRadius=10
        //        cell.layer.borderColor = UIColor.black.cgColor  // set cell border color here
        //        cell.layer.borderWidth = 1 // set border width here
        // Initialization code
//        loaderView.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
