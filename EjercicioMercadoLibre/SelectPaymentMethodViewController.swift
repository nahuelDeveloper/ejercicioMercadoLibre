//
//  SelectPaymentMethodViewController.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 27/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

/*
 *  2nd Payment step: Choosing a payment method
 */
class SelectPaymentMethodViewController: BaseViewController {

    // MARK: - IBOutlets -
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables and Constants -
    
    let kSelectBankSegueIdentifier = "selectBankSegue"
    
    var paymentMethods = [PaymentMethod]()
    var amount : Double!
    
    // MARK: - View lifecycle -
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
        
        self.showProgressHud("Cargando metodos de pago...")
        ConnectionManager.sharedInstance.getPaymentMethods { (paymentMethods, error) in
            self.dismissProgressHud()
            
            if let err = error {
                self.showAlert("Se produjo un error al intentar obtener los metodos de pago")
                print("\(err)")
            
            } else {
                if let payMet = paymentMethods {
                    self.paymentMethods = payMet
                    self.tableView.reloadData()
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
        
        self.tableView.registerNib(UINib(nibName: String(ReusableCell), bundle: nil), forCellReuseIdentifier: String(ReusableCell))
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
    }

    // MARK: - Navigation -

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! SelectBankViewController
        let paymentMethod = sender as! PaymentMethod
        destinationVC.amount = self.amount
        destinationVC.paymentMethod = paymentMethod
    }

}

extension SelectPaymentMethodViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymentMethods.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(ReusableCell)) as! ReusableCell
        let paymentMethod = paymentMethods[indexPath.row]
        cell.configureWithPaymentMethod(paymentMethod)
        return cell
    }
}

extension SelectPaymentMethodViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ReusableTableHeaderView.instanceFromNib()
        header.configureForPaymentMethodSeleciton()
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let paymentMethod = paymentMethods[indexPath.row]
        self.performSegueWithIdentifier(kSelectBankSegueIdentifier, sender: paymentMethod)
    }

}

extension SelectPaymentMethodViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "No hay informacion disponible"
        
        let myAttribute = [ NSForegroundColorAttributeName: UIColor.darkGrayColor() ]
        let myAttrString = NSAttributedString(string: text, attributes: myAttribute)
        
        return myAttrString
    }
}
