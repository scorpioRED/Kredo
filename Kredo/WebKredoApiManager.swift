//
//  WebKredoApiManager.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/11/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import Foundation
import SwiftSoup

class WebKredoApiManager {
    static let sharedInstance = WebKredoApiManager()
    let serverUrl = "https://www.kredodirect.com.ua/"
    
    var sd: String!
    
    
    func login(userId: Int, pwd: String, onSuccess: @escaping(UserData) -> Void, onFailure: @escaping(Error) -> Void) {
        
        var request = URLRequest(url:  URL(string:"\(serverUrl)web")!)
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.httpMethod = "POST"
        
        
        
        
        self.prelogIn(onSuccess: {currentSd in DispatchQueue.main.async{
            
     
            
            let params = "sd=\(currentSd)&operation=login&client_id=\(userId)&password=\(pwd)&lang=UA&btn_ok.x=38&btn_ok.y=13&button=ok&menu=".data(using:String.Encoding.ascii, allowLossyConversion: false)
            

            
            request.httpBody = params
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error!)                                 // some fundamental network error
                    return
                }
                
                print("===Loged==== \n",String(data: data, encoding: .utf8)!)

            }
            task.resume()
            
            
            }}, onFailure: {error in
                print("-Error- ->> ", error.localizedDescription)
                onFailure(error)
        }
        )
        
        
    }
    
    
    func prelogIn(onSuccess: @escaping(String) -> Void, onFailure: @escaping(Error) -> Void )  {
        
        print("startGrab!!!!")
        
        var request = URLRequest(url:  URL(string:"\(serverUrl)web")!)
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request) { respData, response, error in
            guard let respData = respData, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            
            
            do{
                let html: String = String(data: respData, encoding: .utf8)!
                
                let doc: Document = try! SwiftSoup.parse(html)
                let elements = try! doc.select("[name=sd]")//query
                let transaction_id = elements.get(0)//select first element ,
                self.sd = String(try transaction_id.val()) //get value

    
                print("--- SD --->",self.sd)
                onSuccess(self.sd)
                

                
            }catch Exception.Error(let type, let message){
                print("===== msg ===== \n",message)
            }catch{
                print("error")
            }
            
            
//            print("----HTML----- \n",htmlStr )
//            let doc: Document = try SwiftSoup.parse(htmlStr)
//
//            //            let sd =  doc.select("form").first()!
//            let sd =  doc.select("form").select("input").first()!
//            
//            print("+++++ sd ++++++++ \n", sd)
            
        }
        
        
        task.resume()
        
    }
}
