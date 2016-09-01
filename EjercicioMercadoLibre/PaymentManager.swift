//
//  PaymentManager.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 31/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import Foundation

/*
 *  Stores the info selected by the user at the end of the payment process, so it can be shown back on the first screen
 */
class PaymentManager {
    
    static let sharedInstance = PaymentManager()
    
    var amount: Double?
    var paymentMethod: PaymentMethod?
    var bank: Bank?
    var installmentsPlan: InstallmentsPlan?
    
    private init() {}
    
    func storePayment(amount: Double, paymentMethod: PaymentMethod, bank: Bank, installmentsPlan: InstallmentsPlan) {
        
        self.amount = amount
        self.paymentMethod = paymentMethod
        self.bank = bank
        self.installmentsPlan = installmentsPlan
        
    }

}