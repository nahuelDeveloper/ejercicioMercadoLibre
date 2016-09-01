//
//  SelectAmountViewController.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 27/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import UIKit

/*
 *  1st Payment step: Entering a valid amount
 */
class SelectAmountViewController: BaseViewController {

    // MARK: - IBOutlets -
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Variables and constants -
    
    let kPaymentMethdoSegueIdentifier = "selectPaymentMethodSegue"
    
    // MARK: - View lifecycle -
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let paymentManager = PaymentManager.sharedInstance
        
        if let _ = paymentManager.amount {
            self.amountTextField.text = ""
            self.showPayment(paymentManager)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.amountTextField.keyboardType = UIKeyboardType.DecimalPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions -
    
    @IBAction func nextButtonAction(sender: AnyObject) {
        if let amountString = self.amountTextField.text where self.amountTextField.text?.characters.count > 0 {
            if let amount = Double(amountString) {
                self.amountTextField.endEditing(true)
                self.performSegueWithIdentifier(kPaymentMethdoSegueIdentifier, sender: Double(amount))
            } else {
                self.showAlert("Monto invalido")
            }
        } else {
            self.showAlert("Por favor, ingrese un monto")
        }
    }

    // MARK: - Navigation -
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! SelectPaymentMethodViewController
        let amount = sender as! Double
        destinationVC.amount = amount
    }
}

