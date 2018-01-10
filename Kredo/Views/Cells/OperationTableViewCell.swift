//
//  OperationTableViewCell.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/6/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import UIKit

class OperationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var typeImg: UIImageView!
    
    @IBOutlet weak var operationDescription: UILabel!
    
    @IBOutlet weak var operationDate: UILabel!
    
    @IBOutlet weak var operationAmount: UILabel!
    
    @IBOutlet weak var operationCurrency: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
