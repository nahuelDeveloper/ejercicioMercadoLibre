//
//  InstallmentsPlan.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 29/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import Foundation
import ObjectMapper

class InstallmentsPlan: Mappable {
    
    var installments: Int!
    var installmentAmount: Double!
    var totalAmount: Double!
    var recomendedMessage: String!
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        installments <- map["installments"]
        installmentAmount <- map["installment_amount"]
        totalAmount <- map["total_amount"]
        recomendedMessage <- map["recommended_message"]
    }
    
}