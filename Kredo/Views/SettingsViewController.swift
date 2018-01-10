//
//  SettingsViewController.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/4/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PinSwitcherDelegate, TouchIDSwitcherDelegate {

    

    

    @IBOutlet weak var tableView: UITableView!
    
    
    let defaults = UserDefaults.standard
    var isPinAllowed: Bool?
    var isTouchIDAllowed: Bool!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.isPinAllowed = defaults.object(forKey: "pinCode") != nil ? true : false
        self.isTouchIDAllowed = defaults.bool(forKey: "UseTouchID")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func isAllowedTouchId(isAllow: Bool) {
        print("--FRom CELLL is allow Touch ID --- ", isAllow)
        defaults.set(isAllow, forKey: "UseTouchID")
    }
    
    func isAllowedPin(isAllow: Bool) {
        if isAllow {
            self.showInputDialog(title: "Придумай Pin", msg: "введіть пін", isInput: true)
        } else {
            defaults.set(nil, forKey: "pinCode")
            print("new pin is NILL")
        }
    }
    
    
    func showInputDialog(title:String,msg:String, isInput:Bool = true) {
        
        if isInput {
            let alertFielsd = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Змінити", style: .default, handler: {
                alert -> Void in
                
                let firstTextField = alertFielsd.textFields![0] as UITextField
                let secondTextField = alertFielsd.textFields![1] as UITextField
                
                
                if firstTextField.text! == secondTextField.text! && firstTextField.text!.count > 3 {
                    print("new pwd \(firstTextField.text!), again \(secondTextField.text!)")
                    self.defaults.set(firstTextField.text! , forKey: "pinCode")
                    //                    let tmp = self.savedUser!["userId"]
                    //                    print("tmp - > ", tmp!)
                    //                    self.changeAdminUserPwd(updData: ["name":tmp!,"newPwd" : firstTextField.text! ])
                }else {
                    self.showInputDialog(title:"Не корректний Ввід!", msg: "пін не співпадають, або менше 4")
                }
                
                
            })
            
            let cancelAction = UIAlertAction(title: "Відмінити", style: .cancel, handler: {
                (action : UIAlertAction!) -> Void in
                
            })
            cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
            
            alertFielsd.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "новий пін"
            }
            alertFielsd.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "повторіть пін"
            }
            
            alertFielsd.addAction(saveAction)
            alertFielsd.addAction(cancelAction)
            
            self.present(alertFielsd, animated: true, completion: nil)
            
        }else {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.show(alert, sender: nil)
        }
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TouchCell") as! TouchIDTableViewCell
            cell.delegate = self
            cell.selectionStyle = .none
            cell.useTouchIDSwicher.setOn(self.isTouchIDAllowed, animated: true)
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PinCell") as! PinCodeTableViewCell
             // MARK: - For Delegate
            cell.delegate = self
            cell.selectionStyle = .none
            cell.usePinSwicher.setOn(self.isPinAllowed!, animated: true)
            return cell
        }
//        else if indexPath.row == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "UserIDCell") as! PinCodeTableViewCell
//            //            cell.userId!.text = "002"
//            return cell
//        }
//                else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ServerURLCell") as! ServerURLTableViewCell
//                    return cell
//                }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
