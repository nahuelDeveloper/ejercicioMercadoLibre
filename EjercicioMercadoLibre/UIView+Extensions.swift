//
//  UIView+Extensions.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 29/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import UIKit

extension UIView {
    
    func round() {
        self.layer.cornerRadius = self.frame.size.width * 0.5
        self.layer.masksToBounds = true
    }
}