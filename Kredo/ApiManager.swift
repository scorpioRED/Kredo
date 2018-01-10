//
//  ApiManager.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/4/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import Foundation


public enum RequestError: Error {
    case loginFailure
    case sessionError
}

extension RequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .sessionError:
            return NSLocalizedString("час сесії минув", comment: "session timeout")
        case .loginFailure:
            return NSLocalizedString("не вірні облікові данні", comment: "  can't login")
        }
    }
}



class ApiManager {
    static let sharedInstance = ApiManager()
    let serverUrl = "https://www.kredodirect.com.ua/pdax/"
    var authKey: String!
    var sessionID: String!
    
    
    func getCardHistory(cardData: Card,onSuccess: @escaping(Array<OperationHistory>) -> Void, onFailure: @escaping(Error) -> Void) {
        var request = URLRequest(url:  URL(string:"\(serverUrl)account_history")!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        let params = ["curr":cardData.currencu,"branch_id":cardData.branchID,"acc":cardData.number,"session_lang":"UA","range_items":"10","sid":self.sessionID,"range_older":"0"] as [String: Any]
        request.httpBody = try! JSONSerialization.data(withJSONObject: params)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)
                return
            }
            
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                print("----- Card History ----- \n ")
                print(responseObject)
                
                let responseOperationsArray = responseObject["items"]! as! [[String:String]]
                //                print(responseCardsArray[0])
                
                
                var operationsModelList: [OperationHistory] = []
                
                for currentOperation in responseOperationsArray {
                    operationsModelList.append(OperationHistory(creditAccountName: currentOperation["credit_account_name"]!, currency: currentOperation["curr"]!, creditAccountTaxID: currentOperation["credit_account_tax_id"]!, debitAccountTaxID: currentOperation["debit_account_tax_id"]!, creditAccountBranchCode: currentOperation["credit_account_branch_code"]!, amount: currentOperation["amount"]!, orderDate: currentOperation["order_date"]!, execDate: currentOperation["exec_date"]!, description: currentOperation["desc"]!, transDate: currentOperation["trans_date"]!, type: currentOperation["type"]!))
                }
                
                onSuccess(operationsModelList)

                
                
            } catch let jsonError {
                print(jsonError)
                print(String(data: data, encoding: .utf8)!)
                onFailure(jsonError)
                // often the `data` contains informative description of the nature of the error, so let's look at that, too
                
            }
        }
        
        task.resume()

        
        
    }
    
    
    func getCardsData(onSuccess: @escaping(Array<Card>) -> Void, onFailure: @escaping(Error) -> Void) {
        var request = URLRequest(url:  URL(string:"\(serverUrl)account_list")!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        print("--- SID ---- \n ")
        print(self.sessionID, " \n")
        
        let params = ["range_items":"10","sid":self.sessionID,"session_lang":"UA","range_seq": 1,"flt":"ACCOUNT-DETAILS"] as [String : Any]
        request.httpBody = try! JSONSerialization.data(withJSONObject: params)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)
                return
            }
            
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                print("----- Cards ----- \n ")
                print(responseObject)
                
                let responseCardsArray = responseObject["items"]! as! [[String:String]]
//                print(responseCardsArray[0])

                
                var cradModelList: [Card] = []

                for card in responseCardsArray {
                    cradModelList.append(Card(number: card["num"]!, avalibleAmount: card["avail"]!, currencu: card["curr"]!, branchID: card["branch_code"]! ))
                }
                
                onSuccess(cradModelList)
                

            } catch let jsonError {
                print(jsonError)
                print(String(data: data, encoding: .utf8)!)
                onFailure(jsonError)
                // often the `data` contains informative description of the nature of the error, so let's look at that, too
                
            }
        }
        
        task.resume()
        
        
    }
    
    
    func refresh(){
        var request = URLRequest(url:  URL(string:"\(serverUrl)session_refresh")!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let param = ["sid":self.sessionID, "session_lang":"UA"]
        
        print(" ***** Refresh SID --- \n ",self.sessionID)

            
        request.httpBody = try! JSONSerialization.data(withJSONObject: param)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data)
                print(" --- Refresh response --- \n ",responseObject)

                
                
                
                
            } catch let jsonError {
                print(jsonError)
                print(String(data: data, encoding: .utf8)!)
                // often the `data` contains informative description of the nature of the error, so let's look at that, too
                
            }
        }
        task.resume()
        
        
        
    }
    
    func login(userId: String, pwd: String, onSuccess: @escaping(UserData) -> Void, onFailure: @escaping(Error) -> Void) {
        
        var request = URLRequest(url:  URL(string:"\(serverUrl)login")!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.httpMethod = "POST"
        

        
        
        self.prelogIn(onSuccess: {key in DispatchQueue.main.async{
            

            let dictionary = ["client_id":userId,"auth_key":key,"session_lang":"UA","password":pwd]
            request.httpBody = try! JSONSerialization.data(withJSONObject: dictionary)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error!)                                 // some fundamental network error
                    return
                }
                do {
                    let responseObject = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                
                    print("-- logged data ---")
                    print(responseObject)

                    if responseObject["sid"] != nil {
                        self.sessionID = responseObject["sid"] as! String
                        print("=====+++ ",self.sessionID)
                        self.refresh()
                        onSuccess(UserData(name: responseObject["client_name"] as! String, id: responseObject["client_id"] as! String))
                    }else{
                        print("-- wrong login data ---")
                        let wrongLoginError: Error = RequestError.loginFailure
                        onFailure(wrongLoginError)
                    }
                    
                    

                    
                    
                    

                    
                } catch let jsonError {
                    print(jsonError)
                    print(String(data: data, encoding: .utf8)!)
                    let wrongLoginError: Error = RequestError.loginFailure
                    onFailure(wrongLoginError)
                    
                    // often the `data` contains informative description of the nature of the error, so let's look at that, too
                    
                }
            }
            task.resume()
            
            
            }}, onFailure: {error in
                print("-Error- ->> ", error.localizedDescription)
                onFailure(error)
        }
        )
        
        
    }
    
    
    func prelogIn(onSuccess: @escaping(String) -> Void, onFailure: @escaping(Error) -> Void )  {
        
        
        var request = URLRequest(url:  URL(string:"\(serverUrl)login")!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.httpMethod = "POST"
        
        let dictionary = ["preauth":"1", "session_lang":"UA"]
        request.httpBody = try! JSONSerialization.data(withJSONObject: dictionary)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data) as! [String:String]
//                print(responseObject)
                self.authKey = responseObject["auth_key"]!
//                print("-- key is  -- ", self.authKey)
                onSuccess(self.authKey)
            } catch let jsonError {
                print(jsonError)
                print(String(data: data, encoding: .utf8)!)
                onFailure(jsonError)
                
                
            }
        }
        

        task.resume()

    }
    
}
