//
//  ReusableTableHeaderView.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 27/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import UIKit

protocol ReusableTableHeaderViewDelegate {
    func configureForPaymentMethodSeleciton()
    func configureForBankSelection()
    func configureForInstallmentsSelection()
}

class ReusableTableHeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    static func instanceFromNib() -> ReusableTableHeaderView {
        let array = NSBundle.mainBundle().loadNibNamed(String(ReusableTableHeaderView), owner: self, options: nil)
        return array[0] as! ReusableTableHeaderView
    }
    
    func configureForPaymentMethodSeleciton() {
        self.titleLabel.text = "Seleccione el medio de pago"
    }
    
    func configureForBankSelection() {
        self.titleLabel.text = "Seleccione el banco correspondiente"
    }
    
    func configureForInstallmentsSelection() {
        self.titleLabel.text = "Seleccione el plan de pago en cuotas"
    }

}
