//
//  SelectBankViewController.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 27/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

/*
 *  3rd Payment step: Choosing a bank
 */
class SelectBankViewController: BaseViewController {

    // MARK: - IBOutlets -
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables and Constants -
    
    let kSelectInstallmentsSegueIdentifier = "selectInstallmentsSegue"
    
    var banks = [Bank]()
    var amount : Double!
    var paymentMethod : PaymentMethod!
    
    // MARK: - View lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
        
        self.showProgressHud("Cargando bancos...")
        ConnectionManager.sharedInstance.getBanks(self.paymentMethod.id) { (banks, error) in
            self.dismissProgressHud()
            
            if let err = error {
                self.showAlert("Se produjo un error al intentar obtener los bancos")
                print("\(err)")
            } else {
                if let banks = banks {
                    self.banks = banks
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! SelectInstallmentsViewController
        let bank = sender as! Bank
        destinationVC.amount = amount
        destinationVC.bank = bank
        destinationVC.paymentMethod = paymentMethod
    }
}
    
extension SelectBankViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(ReusableCell)) as! ReusableCell
        let bank = banks[indexPath.row]
        cell.configureWithBank(bank)
        return cell
    }
}

extension SelectBankViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ReusableTableHeaderView.instanceFromNib()
        header.configureForBankSelection()
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let bank = banks[indexPath.row]
        self.performSegueWithIdentifier(kSelectInstallmentsSegueIdentifier, sender: bank)
    }
}

extension SelectBankViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "No hay bancos disponibles"
        
        let myAttribute = [ NSForegroundColorAttributeName: UIColor.darkGrayColor() ]
        let myAttrString = NSAttributedString(string: text, attributes: myAttribute)
        
        return myAttrString
    }
}

