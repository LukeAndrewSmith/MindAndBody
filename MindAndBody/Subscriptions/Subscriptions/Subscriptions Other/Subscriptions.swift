//
//  SubscriptionsTest.swift
//  MindAndBody
//
//  Created by Luke Smith on 18.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
// Thanks to Ellina Kuznetcova for the code ideas

import Foundation
import StoreKit
import SwiftyReceiptValidator

enum ProductType: String {
    case threeMonth = "mind_and_body_3month_subscription"
    case yearly = "mind_and_body_yearly_subscription"

    static var all: [ProductType] {
        return [.threeMonth, .yearly]
    }
}

enum InAppErrors: Swift.Error {
    case noSubscriptionPurchased
    case noProductsAvailable

    var localizedDescription: String {
        switch self {
        case .noSubscriptionPurchased:
            return "No subscription purchased"
        case .noProductsAvailable:
            return "No products available"
        }
    }
}

class InAppManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    static let shared = InAppManager()
    
    static let accountSecret = "a255263277c14664afb897c5de689810"

    var products: [SKProduct] = []

    var isTrialPurchased: Bool?
    var expirationDate: Date?
    var purchasedProduct: ProductType?
    
    // Receipt validator
    let receiptValidator = SwiftyReceiptValidator()

    func startMonitoring() {
        SKPaymentQueue.default().add(self)
    }

    func stopMonitoring() {
        SKPaymentQueue.default().remove(self)
    }

    // -------------------------------------------------------------
    // MARK:- Load Products
    func loadProducts() {
        let productIdentifiers = Set<String>(ProductType.all.map({$0.rawValue}))
        let request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
    }
    // Handle request
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard response.products.count > 0 else {return}
        self.products = response.products
        // Notify that products have been loaded
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: SubscriptionNotifiations.productsLoadedNotification, object: self.products)
        }
    }
    // Error
    func request(_ request: SKRequest, didFailWithError error: Error) {
        if request is SKProductsRequest {
            print("Subscription Options Failed Loading: \(error.localizedDescription)")
            // TODO: TRY AND LOAD AGAIN
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: SubscriptionNotifiations.connectionTimedOutNotification, object: nil)
            }
        }
    }
    
    // -------------------------------------------------------------
    // MARK:- Purchase Products
    func purchaseProduct(productType: ProductType) {
        guard let product = self.products.filter({$0.productIdentifier == productType.rawValue}).first else {
            // No products available
            return
        }
        if SKPaymentQueue.canMakePayments() {
            let payment = SKMutablePayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            // TODO: Popup
            print("Payments disabled")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("Purchasing")
            case .purchased:
                queue.finishTransaction(transaction)
                // check
                let productIdentifier = transaction.payment.productIdentifier
                receiptValidator.validate(productIdentifier, sharedSecret: InAppManager.accountSecret) { result in
                    switch result {
                    case .success(let data):
                        self.checkExpiryDateAction(response: data, action: 1, failedNotification: true)
                    case .failure(let code, let error):
                        print("Receipt validation failed with code \(code), error \(error.localizedDescription)")
                        // Failed
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: SubscriptionNotifiations.purchaseFailedNotification, object: nil)
                        }
                    }
                }
            case .failed:
                queue.finishTransaction(transaction)
                // Failed
                if let transactionError = transaction.error as NSError?,
                    transactionError.code != SKError.paymentCancelled.rawValue {
                    // Timed out/ failed
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: SubscriptionNotifiations.purchaseFailedNotification, object: nil)
                    }
                    // Cancelled
                } else {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: SubscriptionNotifiations.dismissLoading, object: nil)
                    }
                }
            case .restored:
                queue.finishTransaction(transaction)
            case .deferred:
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: SubscriptionNotifiations.restoreFailedNotification, object: nil)
                }
            }
        }
    }
    
    // -------------------------------------------------------------
    // MARK:- Restore Products
    func restoreSubscription() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    // Restore failed with error
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Swift.Error) {
        // Cancel transaction
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: SubscriptionNotifiations.restoreFailedNotification, object: nil)
        }
    }
    
    // Restore transaction finished
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("Transaction Finished")
        validateLocalReceipt(action: 1)
    }

    // -------------------------------------------------------------
    // MARK:- Check Subscription
    func validateLocalReceipt(action: Int) {
        // Attempt to validate receipt for all subscription types
        print("Validating")
        var failures = 0
        for i in 0..<ProductType.all.count {
            receiptValidator.validate(ProductType.all[i].rawValue, sharedSecret: InAppManager.accountSecret) { result in
                switch result {
                case .success(let data):
                    print("Success")
                    if action == 0 {
                        self.checkExpiryDateAction(response: data, action: 0, failedNotification: false)
                    } else if action == 1 {
                        self.checkExpiryDateAction(response: data, action: 1, failedNotification: true)
                    }
                case .failure(let code, let error):
                    print("Receipt validation failed with code \(code), error \(error.localizedDescription)")
                    // Only indicate if all products failed
                    failures += 1
                    print(failures)
                    if failures == self.products.count {
                        if action == 0 {
                            // Call didChecksubscriptions, this calls a func which also checks the .isValid variable and present the subscription screen if not
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: SubscriptionNotifiations.didCheckSubscription, object: nil)
                            }
                        } else if action == 1 {
                            // Indicate no subscription associated with apple id
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: SubscriptionNotifiations.connectionTimedOutNotification, object: nil)
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: Check reciept/expiry date
    // Check expiry dates
        // Posts notifications that call functions
    // Note on action parameter
        // 0 == not called from subscription screen, i.e called from app delegate when first opening and checking to see wether or not to present subscription screen
        // 1 == Restore/Purchase -> dismiss subscription screen, present walkthrough
    func checkExpiryDateAction(response: [String: AnyObject]?, action: Int, failedNotification: Bool) {
        SubscriptionsCheck.shared.isValid = false
        /// Retreive the full apple receipt
        let receiptKey = SwiftyReceiptValidator.ResponseKey.receipt.rawValue
        if let receipt = response![receiptKey] {
            // Retreive the array of in-app purchase receipts
            let inAppKey = SwiftyReceiptValidator.InfoKey.inApp.rawValue
            if let inApp = receipt[inAppKey] as? [AnyObject] {
                // Loop all in-app purchase receipts
                for receiptInApp in inApp {
                    // Find the expiry date of the in-app purchase receipt
//                    let expiryDateKey = SwiftyReceiptValidator.InfoKey.InApp.expiresDate.rawValue
                    // Using expires_date_ms, i beleive that I'm allowed to
                    if let expiryDate = receiptInApp["expires_date_ms"] as? String {
                        // Check expiry date
                        // Valid subscription
                        if isValidExpiryDate(expiryDate: expiryDate) {
                            // Valid subscription found
                            UserDefaults.standard.set(expiryDate, forKey: "userSubscriptionExpiryDate")
                            SubscriptionsCheck.shared.isValid = true
                            Loading.shared.shouldPresentLoading = false
                            // Broadcast success notifications
                            if action == 1 {
                                DispatchQueue.main.async {
                                    NotificationCenter.default.post(name: SubscriptionNotifiations.purchaseRestoreSuccessfulNotification, object: nil)
                                }
                            }
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: SubscriptionNotifiations.didCheckSubscription, object: nil)
                                NotificationCenter.default.post(name: SubscriptionNotifiations.canPresentWalkthrough, object: nil)
                            }
                            break
                        }
                    }
                }
                
                // No valid subscription
                if !SubscriptionsCheck.shared.isValid {
                    // If no valid subscription found
                    if failedNotification {
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: SubscriptionNotifiations.restoreFailedNotification, object: nil)
                        }
                    }
                    SubscriptionsCheck.shared.isValid = false
                    Loading.shared.shouldPresentLoading = false
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: SubscriptionNotifiations.didCheckSubscription, object: nil)
                    }
                }
            }
        }
    }

    // Check if subscription is valid
    func isValidExpiryDate(expiryDate: String) -> Bool {
        // Comes as ms since 1970, convert to s then to date
        let expiryDateS = Double(expiryDate)! / 1000
        return (Date().timeIntervalSince1970 < expiryDateS)
    }
}
