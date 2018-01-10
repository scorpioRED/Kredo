//
//  CardModel.swift
//  Kredo
//
//  Created by Vitaliy Heras on 1/5/18.
//  Copyright © 2018 Vitaliy Heras. All rights reserved.
//

import Foundation


struct Card {
    var number: String
    var avalibleAmount: String
    var currencu: String
    var branchID: String
    
    init(number: String, avalibleAmount: String, currencu: String, branchID: String) {
        self.number = number
        self.avalibleAmount = avalibleAmount
        self.currencu = currencu
        self.branchID = branchID
    }
}
