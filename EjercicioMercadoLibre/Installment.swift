//
//  Installment.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 29/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import Foundation
import ObjectMapper

class Installment: Mappable {
    
    var installmentsPlan: [InstallmentsPlan]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        installmentsPlan <- map["payer_costs"]
        
    }
    
}