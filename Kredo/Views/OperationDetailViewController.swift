//
//  OperationDetailViewController.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/10/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import UIKit

class OperationDetailViewController: UIViewController {
    
    var currentrOperation: OperationHistory!
    var allDescr = ""
    
    @IBOutlet weak var typeImage: UIImageView!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var descrBgView: UIView!
    @IBOutlet weak var allDescription: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descrBgView.layer.cornerRadius = 10
        
        if currentrOperation!.type.range(of: "Надходження") != nil || currentrOperation!.type.range(of: "поступлення") != nil {
            self.typeImage.image = #imageLiteral(resourceName: "piggy-bank")
            self.amountLabel.textColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            self.amountLabel?.text = "+\(currentrOperation.amount) \(currentrOperation.currency)"
        }else {
            self.amountLabel?.text = "-\(currentrOperation.amount) \(currentrOperation.currency)"
        }

        
        self.dateLabel?.text = currentrOperation.transDate
        
        
        
        for descrLine in currentrOperation.description.split(separator: ",") {
            allDescr+="\(descrLine)\n"
        }
        
        self.allDescription?.text = allDescr
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func shareBtn(_ sender: Any) {
        // text to share
        let sharedLabel = "Операція від: \(self.currentrOperation.transDate)\n\n\(self.allDescr)"
        
        // set up activity view controller
        let textToShare = [sharedLabel]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
//        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func doneBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
