//
//  BaseViewController.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 31/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import UIKit
import SVProgressHUD
import NYAlertViewController

/*
 *  Default view controller with properties and methods that will be used by all the other view controllers
 */
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    
    func showAlert(text: String){
        let alertController = UIAlertController(title: "Mercadolibre", message:
            text, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showProgressHud() {
        SVProgressHUD.show()
    }
    
    func showProgressHud(title: String) {
        SVProgressHUD.showWithStatus(title)
    }
    
    func dismissProgressHud() {
        SVProgressHUD.dismiss()
    }
    
    func showPayment(paymentManager: PaymentManager) {
        let alertViewController = NYAlertViewController()
        
        // Set a title and message
        alertViewController.title = "Felicitaciones!!"
        
        var message = "\nEl proceso de pago fue completado con exito\n\n"
        message += "Monto: \(String(format: "%.2f", paymentManager.amount!))\n"
        message += "Medio de pago: \(paymentManager.paymentMethod!.name)\n"
        message += "Banco: \(paymentManager.bank!.name)\n\n"
        message += "Nro de cuotas: \(paymentManager.installmentsPlan!.installments)\n"
        message += "Monto por cuota: \(String(format: "%.2f", paymentManager.installmentsPlan!.installmentAmount))\n"
        message += "Monto total: \(String(format: "%.2f", paymentManager.installmentsPlan!.totalAmount))\n"
        alertViewController.message = message
        
        alertViewController.backgroundTapDismissalGestureEnabled = true
        
        // Add alert actions
        let cancelAction = NYAlertAction(
            title: "Ok",
            style: .Cancel,
            handler: { (action: NYAlertAction!) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        )
        alertViewController.addAction(cancelAction)
        
        // Present the alert view controller
        self.presentViewController(alertViewController, animated: true, completion: nil)
    }

}
