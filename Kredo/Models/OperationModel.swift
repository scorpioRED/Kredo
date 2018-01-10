//
//  OperationModel.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/5/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import Foundation

struct OperationHistory {
    
    var creditAccountName: String
    var currency: String
    var creditAccountTaxID: String
    var debitAccountTaxID: String
    var creditAccountBranchCode: String
    var amount: String
    var execDate: String
//    "debit_account_branch_code": "325365",
    var orderDate: String
    var description: String
    var transDate: String
    var type: String
    
//    "id": "140710221",
//    "debit_account_no": "26254010644331",
//    "debit_account_name": "????? ??????? ??????????",
//    "credit_account_no": "292400401"
    
    
    init(creditAccountName:String, currency: String, creditAccountTaxID: String, debitAccountTaxID: String, creditAccountBranchCode: String,amount: String, orderDate: String,execDate: String, description: String, transDate: String, type: String ) {
        self.creditAccountName = creditAccountName
        self.currency = currency
        self.creditAccountTaxID = creditAccountTaxID
        self.debitAccountTaxID = debitAccountTaxID
        self.creditAccountBranchCode = creditAccountBranchCode
        self.amount = amount
        self.execDate = execDate
        self.orderDate = orderDate
        self.description = description
        self.transDate = transDate
        self.type = type
        
    }
    
}
