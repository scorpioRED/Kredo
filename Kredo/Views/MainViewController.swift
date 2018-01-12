//
//  MainViewController.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/4/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    @IBOutlet weak var tableView: UITableView!
    
    var cardList:[Card]!

    /// View which contains the loading text and the spinner
    let loadingView = UIView()
    
    /// Spinner shown during load the TableView
    let spinner = UIActivityIndicatorView()
    
    /// Text shown during load the TableView
    let loadingLabel = UILabel()
    
//    @IBOutlet weak var cardPlaceLoader: UIActivityIndicatorView!
    
    
    var user: UserData!
    
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    
    var refreshControl: UIRefreshControl!
    
    @IBAction func lgOutTmp(_ sender: Any) {
        Switcher.updateRootVC()
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchCards()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.setLoadingScreen ()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Потягни щоб оновити")
        refreshControl.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        refreshControl.addTarget(self, action: #selector(MainViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
//        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
//        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.tableView.estimatedRowHeight = 80
//        self.tableView.rowHeight = UITableViewAutomaticDimension
//
        self.tableView.separatorStyle = .none
        
        userID?.text = user.id
        userName?.text = user.name
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func refresh(_ sender: Any) {
        
        self.fetchCards()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func fetchCards() {
//            self.cardPlaceLoader.isHidden = false
        ApiManager.sharedInstance.getCardsData(onSuccess: {cardsList in DispatchQueue.main.async{
            print("---- cards List in VC ---- ")
            print(cardsList)
            self.cardList = cardsList
            self.tableView.reloadData()
            self.removeLoadingScreen()
//            self.cardPlaceLoader.isHidden = true
            
            
            }}, onFailure: {error in
                print("in error Table VC, error is ->> ", error.localizedDescription)
                DispatchQueue.main.async(execute: {
                    // work Needs to be done
                    //                    self.removeLoadingScreen()
                    //                    self.showAlert(title: "Упсс!!!", msg: nil, err: error)
                })
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.cardList != nil) {
            return self.cardList.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CardsListTableViewCell
        
//        cell.layer.cornerRadius=10
//        cell.layer.borderColor = UIColor.black.cgColor  // set cell border color here
//        cell.layer.borderWidth = 1 // set border width here
        
        cell.cardNumber.text = self.cardList[indexPath.row].number
        cell.cardBalance.text = self.cardList[indexPath.row].avalibleAmount
        cell.cardCurrencu.text = self.cardList[indexPath.row].currencu
//        cell.loaderView.isHidden = false
        
        return cell
    }
    

    func setLoadingScreen() {
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (tableView.frame.width / 2) - (width / 2)
        let y = (tableView.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Викачую..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        
        // Sets spinner
        spinner.activityIndicatorViewStyle = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)
        
        tableView.addSubview(loadingView)
        
    }
    
    
     func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is OperationsListTableViewController {
            if let OperationVC = segue.destination as? OperationsListTableViewController {
                if let indexpath = self.tableView.indexPathForSelectedRow {
                    let selectedCard = self.cardList[indexpath.row]
                    OperationVC.selectedCard = selectedCard
                }
            }
            
        }
//        if segue.identifier == "fromMainToOperationsList" {
//            let OperationVC = segue.description as! OperationsListTableViewController
//            if let indexpath = self.tableView.indexPathForSelectedRow {
//                let selectedCard = self.cardList[indexpath.row]
//                OperationVC.selectedCard = selectedCard
//            }
//        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
