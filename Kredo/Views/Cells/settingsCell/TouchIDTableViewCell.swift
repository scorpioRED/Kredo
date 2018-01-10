//
//  TouchIDTableViewCell.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/4/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import UIKit

protocol TouchIDSwitcherDelegate {
    func isAllowedTouchId(isAllow: Bool)
}

class TouchIDTableViewCell: UITableViewCell {
    
    var delegate: TouchIDSwitcherDelegate?
    @IBOutlet weak var useTouchIDSwicher: UISwitch!
    
    @IBAction func touchIdSwitcherAction(_ sender: UISwitch) {
        
        self.delegate?.isAllowedTouchId(isAllow: sender.isOn)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
