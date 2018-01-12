//
//  TransfersOptionsViewController.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/12/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import UIKit

class TransfersOptionsViewController: UIViewController {
    
    
    @IBOutlet weak var onceTransfer: UIButton!
    @IBOutlet weak var beatwenTransfer: UIButton!
    @IBOutlet weak var fromPatternTransfer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roundedBtn()
        

        // Do any additional setup after loading the view.
    }

//    button.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
//    button.layer.cornerRadius = 0.5 * button.bounds.size.width
//    button.clipsToBounds = true
    
    
    func roundedBtn () {
        self.onceTransfer.layer.cornerRadius = 0.5 * self.onceTransfer.bounds.size.width
//        self.onceTransfer.titleLabel?.lineBreakMode = .byCharWrapping
        self.onceTransfer.titleLabel?.textAlignment = .center
//        self.onceTransfer.layer.borderColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
//        self.onceTransfer.layer.borderWidth = 0.5
//        onceTransfer.clipsToBounds = true
        
        self.beatwenTransfer.layer.cornerRadius = 0.5 * self.beatwenTransfer.bounds.size.width
//        self.beatwenTransfer.layer.borderColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
//        self.beatwenTransfer.layer.borderWidth = 0.5
//        beatwenTransfer.clipsToBounds = true
//        self.beatwenTransfer.titleLabel?.lineBreakMode = .byCharWrapping
        self.beatwenTransfer.titleLabel?.textAlignment = .center
        
        
        self.fromPatternTransfer.layer.cornerRadius = 0.5 * self.fromPatternTransfer.bounds.size.width
        self.fromPatternTransfer.layer.borderColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        self.beatwenTransfer.layer.borderWidth = 0.5
        fromPatternTransfer.clipsToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
