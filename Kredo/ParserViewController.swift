//
//  ParserViewController.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/11/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import UIKit
//import SwiftSoup

class ParserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.login()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func login(){
        
        WebKredoApiManager.sharedInstance.prelogIn(onSuccess: {result in DispatchQueue.main.async{
            print("Result is \n ")
            print(result)

            
            
            }}, onFailure: {error in
                print("in error Login VC, error is ->> ", error.localizedDescription)
                DispatchQueue.main.async(execute: {
                    print("error!!!")

                })
                
                
        })
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
