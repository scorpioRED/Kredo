//
//  Switcher.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/9/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import Foundation
import UIKit



class Switcher {
    
    static func updateRootVC(){
        
        //let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC : UIViewController?
        
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginvc") as! LoginViewController
        
        //print(status)
        
        
       // if(status == true){
       //     rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbarvc") as! //TabBarVC
       // }else{
       //     rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginvc") as! LoginVC
       // }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
