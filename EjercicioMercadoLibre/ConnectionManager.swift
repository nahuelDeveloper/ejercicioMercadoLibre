//
//  ConnectionManager.swift
//  EjercicioMercadoLibre
//
//  Created by Nahuel Roldan on 28/8/16.
//  Copyright © 2016 nahuelDeveloper. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol PaymentDelegate {
    func getPaymentMethods(completion: (paymentMethods: [PaymentMethod]?, error: String?) -> Void)
    func getBanks(paymentMethodId: String, completion: (banks: [Bank]?, error: String?) -> Void)
    func getInstallments(paymentMethodId: String, amount: String, bankId: String, completion: (installments: [Installment]?, error: String?) -> Void)
}

class ConnectionManager {
    
    // MARK: - Singleton -
    static let sharedInstance = ConnectionManager()
    
    private var publicKey = "public_key=444a9ef5-8a6b-429f-abdf-587639155d88"
    
    private var baseURL = "https://api.mercadopago.com/v1"
    
    private var paymentMethodsURL = "/payment_methods"
    private var banksURL = "/card_issuers"
    private var installmentsURL = "/installments"
    
    private init() {}
    
    private func getRequest(url: String, apiCompletion: (responseValue: AnyObject?, error: String?) -> Void) {
        
        Alamofire
            .request(Method.GET, url, encoding: ParameterEncoding.JSON, headers: nil)
            .responseJSON { (response) in
                
                guard let value = response.result.value else {
                    apiCompletion(responseValue: nil, error: "error_connection")
                    return
                }
                
                if response.result.isSuccess {
                    if response.response?.statusCode == 200 {
                        
                        apiCompletion(responseValue: value, error: nil)
                        return
                        
                    }  else {
                        
                        if let errorDetail = value["code"] as? String {
                            apiCompletion(responseValue: value, error: errorDetail)
                        }  else {
                            apiCompletion(responseValue: value, error: "error_default")
                        }
                        return
                    }
                    
                } else if response.result.isFailure {
                    
                    apiCompletion(responseValue: value, error: "error_connection")
                    
                    return
                }
        }
    }
}

extension ConnectionManager: PaymentDelegate {
    
    func getPaymentMethods(completion: (paymentMethods: [PaymentMethod]?, error: String?) -> Void) {
        
        let url = "\(baseURL+paymentMethodsURL)?\(publicKey)"
        
        getRequest(url) { (responseValue, error) in
            if error == nil {
                
                let paymentMethods = Mapper<PaymentMethod>().mapArray(responseValue)
                completion(paymentMethods: paymentMethods, error: error)
                
            } else {

                completion(paymentMethods: nil, error: error)
            }
        }
    }
    
    func getBanks(paymentMethodId: String, completion: (banks: [Bank]?, error: String?) -> Void) {
        
        let url = "\(baseURL+paymentMethodsURL+banksURL)?\(publicKey)&payment_method_id=\(paymentMethodId)"
        
        getRequest(url) { (responseValue, error) in
            if error == nil {
                
                let banks = Mapper<Bank>().mapArray(responseValue)
                completion(banks: banks, error: error)
                
            } else {
                
                completion(banks: nil, error: error)
            }
        }
    }
    
    func getInstallments(paymentMethodId: String, amount: String, bankId: String, completion: (installments: [Installment]?, error: String?) -> Void) {
        
        let url = "\(baseURL+paymentMethodsURL+installmentsURL)?\(publicKey)&amount=\(amount)&payment_method_id=\(paymentMethodId)&issuer.id=\(bankId)"
        
        getRequest(url) { (responseValue, error) in
            if error == nil {
                
                let installments = Mapper<Installment>().mapArray(responseValue)
                completion(installments: installments, error: error)
                
            } else {
                
                completion(installments: nil, error: error)
            }
        }
        
    }
    
}