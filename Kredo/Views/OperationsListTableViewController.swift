//
//  OperationsListTableViewController.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/5/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import UIKit

class OperationsListTableViewController: UITableViewController {
    
    @IBOutlet weak var loaderView: UIView!
    var selectedCard: Card!
    var operationsList:[OperationHistory] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("############ Card in TABLE ############# \n ", selectedCard)
        self.tableView.separatorStyle = .none
        fetchOperationsHistory(card: selectedCard)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return operationsList.count
    }

    func fetchOperationsHistory(card: Card) {
        ApiManager.sharedInstance.getCardHistory(cardData: card,onSuccess: {operationsList in DispatchQueue.main.async{
            print("---- Operations in VC ---- ")
            print(operationsList)
            self.operationsList = operationsList
            self.tableView.reloadData()
            self.loaderView.isHidden = true

            }}, onFailure: {error in
                print("in error Table VC, error is ->> ", error.localizedDescription)
                DispatchQueue.main.async(execute: {
                    // work Needs to be done
                    //                    self.removeLoadingScreen()
                    //                    self.showAlert(title: "Упсс!!!", msg: nil, err: error)
                })
        })
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "operationCell", for: indexPath) as! OperationTableViewCell
//        cell.layer.cornerRadius = 9
        cell.bgView.layer.cornerRadius = 9
//        cell.layer.borderColor = UIColor.black.cgColor  // set cell border color here
//        cell.layer.borderWidth = 0.3 // set border width here
        

        
        var description: String!
        
        cell.operationDate.text = self.operationsList[indexPath.row].transDate
        cell.operationCurrency.text = self.operationsList[indexPath.row].currency
        if self.operationsList[indexPath.row].type.range(of: "Надходження") != nil || self.operationsList[indexPath.row].type.range(of: "поступлення") != nil {
            description = self.operationsList[indexPath.row].description
            cell.typeImg.image = #imageLiteral(resourceName: "piggy-bank")
            cell.operationAmount.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            cell.operationCurrency.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            cell.operationAmount.text = "+\(self.operationsList[indexPath.row].amount)"
        }else {
//            var secondString = ""
//
//            if self.operationsList[indexPath.row].description.split(separator: ",")[1].range(of: "Код") != nil {
//                secondString = self.operationsList[indexPath.row].description.split(separator: ",")[1].replacingOccurrences(of: "Код  ", with:"")
//            }else {
//                secondString = String(self.operationsList[indexPath.row].description.split(separator: ",")[1])
//            }
            description = """
            \(self.operationsList[indexPath.row].description.split(separator: ",")[0].split(separator: "Д")[0])
            \(self.operationsList[indexPath.row].description.split(separator: ",").count > 1 ? self.operationsList[indexPath.row].description.split(separator: ",")[1].replacingOccurrences(of: "Код  ", with:"") : String(self.operationsList[indexPath.row].description))
            """
            
            cell.operationAmount.text = "-\(self.operationsList[indexPath.row].amount)"
        }
        
        cell.operationDescription.text = description
        return cell
    }

    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOperaionDetail" {
            let OVC = segue.destination as! OperationDetailViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                OVC.currentrOperation = operationsList[indexPath.row]
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    */

}
