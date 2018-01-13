//
//  ViewController.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/4/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import UIKit
import LocalAuthentication


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let defaults = UserDefaults.standard
    
    var useTouchID:Bool?
    var userPin: String?
    var savedUser:[String:String]?
    
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var user: UserData!
    
    
    @IBOutlet weak var pinView: UIView!
    
    @IBOutlet weak var logPassView: UIView!
    
    @IBOutlet weak var pinCode: UITextField!
    
    
    @IBOutlet weak var clientID: UITextField!
    @IBOutlet weak var clientPwd: UITextField!
    
    
    @IBAction func loginByTouchIdBtn(_ sender: UIButton) {
        if useTouchID! && (savedUser != nil) {
            self.authenticateUser(usr: savedUser!["usId"]!, pwd: savedUser!["pw"]!)
        }
    }
    
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        if self.userPin != nil {
            print("pin->> ", pinCode.text!)
            print(self.userPin!)
            if pinCode.text! == self.userPin! {
                print("saved --- >  ",savedUser!)
                
                print(savedUser!["usId"]!, savedUser!["pw"]!)
                self.login(userId: savedUser!["usId"]! , pwd: savedUser!["pw"]!)
                self.pinCode.text = ""
            }else{
                self.showAlert(title: "УПС", msg: "Не корректні дані :(", err: nil)
            }
        }else {
            if clientID.text!.count != 8 {
                self.showAlert(title: "УПС", msg: "Id має мати 8 символів", err: nil)
            }else{
                self.login(userId: clientID.text!, pwd: clientPwd.text!)
            }
            
        }
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = true
        self.clientID?.delegate = self
        self.clientPwd?.delegate = self
        self.pinCode?.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.preLogin()
    }
    
    
    func preLogin(){

        WebKredoApiManager.sharedInstance.login(userId: 11111111, pwd: "22222222",onSuccess: {result in DispatchQueue.main.async{
            print("Result in prelogin is \n ")
            
            
            }}, onFailure: {error in
                print("in error Login VC, error is ->> ", error.localizedDescription)
                DispatchQueue.main.async(execute: {
                    print("error!!!")
                
                })
                
                
        })
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isPinCodeAndTouchAllowed()

    }
    
    
    func isPinCodeAndTouchAllowed() {
        self.userPin = defaults.string(forKey: "pinCode")
        if  self.userPin != nil {
            print("--------- pin is allowed ------------ ")

            self.pinView.isHidden = false
            self.logPassView.isHidden = true
        } else {
            print("-------- pin is dissabled ------------")
            self.logPassView.isHidden = false
            self.pinView.isHidden = true
        }
        
        
        self.useTouchID = defaults.bool(forKey: "UseTouchID")
        
//        print("******** TOUCH ********** ",  self.useTouchID)
        
        self.savedUser = defaults.object(forKey: "savedUser") as? [String: String]
        
        
        
        
        
//        print("savedUser ---> ", self.savedUser)
        
        if useTouchID! && (savedUser != nil) {
            self.authenticateUser(usr: savedUser!["usId"]!, pwd: savedUser!["pw"]!)
        }

    }
    
    func login(userId: String, pwd: String){
        self.loadingView.isHidden = false
        ApiManager.sharedInstance.login(userId: userId, pwd: pwd, onSuccess: {result in DispatchQueue.main.async{
            print("Result is \n ")
            self.user = result
            print(self.user)
            self.loadingView.isHidden = true
            self.defaults.set(["usId":userId,"pw":pwd], forKey: "savedUser")
            self.clientID.text = ""
            self.clientPwd.text = ""
            
            self.performSegue(withIdentifier: "fromLoginToMain", sender: nil)
            
            
            }}, onFailure: {error in
                print("in error Login VC, error is ->> ", error.localizedDescription)
                DispatchQueue.main.async(execute: {
                    print("error!!!")
                    self.loadingView.isHidden = true
                    self.showAlert(title: "Упсс!", msg: nil, err: error)
                })
                
                
        })
    }
    
    
    
    
    func authenticateUser(usr:String, pwd:String) {
        
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Ідентифікуйтесь"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        //                        self.runSecretCode()
                        print("Success Ener!!!!")
                        self.login(userId: usr,pwd: pwd)
                    } else {
                        let ac = UIAlertController(title: "Автентифікацію не пройдено", message: "Спробуйте ще раз!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch/Face ID не доступний", message: "На вашому девайсі немає Touch/Face ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromLoginToMain" {
            let navController = segue.destination as! UINavigationController
            let mainVC = navController.topViewController as! MainViewController
            mainVC.user = self.user
//            mainVC.textOfLabel = "Lowers"
//            mainVC.creator = self.creator
        }
    }
    
    

    func showAlert(title: String, msg:String?, err: Error?) {
        var msgToallert: String?
        if (err != nil) {
            msgToallert = err!.localizedDescription
        }
        else{
            msgToallert = msg!
        }
        let alert = UIAlertController(title: title, message: msgToallert, preferredStyle: .alert)
        //                let alert = UIAlertController(title: "Упсс!!!", message: "Мабуть гасло не вірне", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.show(alert, sender: nil)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }

}

