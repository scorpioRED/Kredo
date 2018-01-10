//
//  PinCodeTableViewCell.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/4/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import UIKit

protocol PinSwitcherDelegate {
    func isAllowedPin(isAllow: Bool)
}

class PinCodeTableViewCell: UITableViewCell {

    var delegate: PinSwitcherDelegate?
    
//    let defaults = UserDefaults.standard
    
    @IBOutlet weak var usePinSwicher: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let usePin = defaults.bool(forKey: "usePin")
//        usePinSwicher.setOn(usePin, animated: true)
        // Initialization code
    }

    @IBAction func usePinAction(_ sender: UISwitch) {
        print("switch is ->> ", sender.isOn)
        self.delegate?.isAllowedPin(isAllow: sender.isOn)
//        defaults.set(sender.isOn, forKey: "usePin")
//        if sender.isOn {
//            print("will show allert ---")
////            self.delegate?.isAllowedPin(isAllow: true)
//            if let delegate = self.delegate {
//                delegate.isAllowedPin(isAllow: true)
//            }
////            self.showInputDialog(title: "Придумай Pin", msg: "введіть пін", isInput: true)
//
//        }else {
//            defaults.set(nil, forKey: "pinCode")
//        }
    }
    
    
    

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
