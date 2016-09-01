//
//  PaymentMethod.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 27/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import Foundation
import ObjectMapper

class PaymentMethod: Mappable {
    
    var id: String!
    var name: String!
    var thumbnail: String!
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        thumbnail <- map["thumbnail"]
    }
    
}