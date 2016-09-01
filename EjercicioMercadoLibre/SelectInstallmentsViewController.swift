//
//  SelectInstallmentsViewController.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 27/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

/*
 *  4th and last Payment step: Choosing an installments plan
 */
class SelectInstallmentsViewController: BaseViewController {
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables and constants -
    
    var installmentsPlans = [InstallmentsPlan]()
    var amount : Double!
    var paymentMethod : PaymentMethod!
    var bank : Bank!
    
    // MARK: - View lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
        
        self.showProgressHud("Cargando planes de pago...")
        ConnectionManager.sharedInstance.getInstallments(paymentMethod.id, amount: String(format:"%.2f", amount), bankId: bank.id) { (installments, error) in
            self.dismissProgressHud()
            
            if let err = error {
                self.showAlert("Se produjo un error al intentar obtener los planes de pago")
                print("\(err)")
            } else {
                if let inst = installments?.first {
                    if let instPlan = inst.installmentsPlan {
                        self.installmentsPlans = instPlan
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Methods -
    
    func configureTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
    }

}

extension SelectInstallmentsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return installmentsPlans.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DefaultCell", forIndexPath: indexPath)
        let installmentsPlan = self.installmentsPlans[indexPath.row]
        cell.textLabel?.text = installmentsPlan.recomendedMessage
        return cell
    }
}

extension SelectInstallmentsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ReusableTableHeaderView.instanceFromNib()
        header.configureForInstallmentsSelection()
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let installmentsPlan = self.installmentsPlans[indexPath.row]
        PaymentManager.sharedInstance.storePayment(self.amount, paymentMethod: self.paymentMethod, bank: self.bank, installmentsPlan: installmentsPlan)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}

extension SelectInstallmentsViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "No hay planes de pago disponibles"
        
        let myAttribute = [ NSForegroundColorAttributeName: UIColor.darkGrayColor() ]
        let myAttrString = NSAttributedString(string: text, attributes: myAttribute)
        
        return myAttrString
    }
}
