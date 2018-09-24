//
//  SubscriptionsTest.swift
//  MindAndBody
//
//  Created by Luke Smith on 18.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
// Thanks to Ellina Kuznetcova for the code

import Foundation
import StoreKit

enum ProductType: String {
    case yearly = "mind_and_body_yearly_subscription"

    static var all: [ProductType] {
        return [.yearly]
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

protocol InAppManagerDelegate: class {
    func inAppLoadingStarted()
    func inAppLoadingSucceded(productType: ProductType)
    func inAppLoadingFailed(error: Swift.Error?)
//    func subscriptionStatusUpdated(value: Bool)
}

class InAppManager: NSObject {
    static let shared = InAppManager()
    
    static let accountSecret = "a255263277c14664afb897c5de689810"

    weak var delegate: InAppManagerDelegate?

    var products: [SKProduct] = []

    var isTrialPurchased: Bool?
    var expirationDate: Date?
    var purchasedProduct: ProductType?

//    var isSubscriptionAvailable: Bool = true
//    {
//        didSet(value) {
//            self.delegate?.subscriptionStatusUpdated(value: value)
//        }
//    }

    func startMonitoring() {
        SKPaymentQueue.default().add(self)
    }

    func stopMonitoring() {
        SKPaymentQueue.default().remove(self)
    }

    func loadProducts() {
        let productIdentifiers = Set<String>(ProductType.all.map({$0.rawValue}))
        let request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
    }

    func purchaseProduct(productType: ProductType) {
        guard let product = self.products.filter({$0.productIdentifier == productType.rawValue}).first else {
            self.delegate?.inAppLoadingFailed(error: InAppErrors.noProductsAvailable)
            return
        }
        let payment = SKMutablePayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    func restoreSubscription() {
        SKPaymentQueue.default().restoreCompletedTransactions()
        self.delegate?.inAppLoadingStarted()
    }

    func checkSubscriptionAvailability() {
        //
        let productIdentifier = "mind_and_body_yearly_subscription"
        //
        // Validate receipt
        SwiftyReceiptValidator.validate(forIdentifier: productIdentifier, sharedSecret: InAppManager.accountSecret) { (success, response) in
            if success {
                self.checkExpiryDateAction(response: response, action: 0)
            } else {
                // Timed out/ failed
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: SubscriptionNotifiations.didCheckSubscription, object: nil)
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
    func checkExpiryDateAction(response: [String: AnyObject]?, action: Int) {
        /// Retreive the full apple receipt
        let receiptKey = SwiftyReceiptValidator.ResponseKey.receipt.rawValue
        if let receipt = response![receiptKey] {
            // Retreive the array of in-app purchase receipts
            let inAppKey = SwiftyReceiptValidator.InfoKey.in_app.rawValue
            if let inApp = receipt[inAppKey] as? [AnyObject] {
                // Loop all in-app purchase receipts
                for receiptInApp in inApp {
                    // Find the expiry date of the in-app purchase receipt
                    let expiryDateKey = SwiftyReceiptValidator.InfoKey.InApp.expires_date_ms.rawValue
                    if let expiryDate = receiptInApp[expiryDateKey] as? String {
                        // Check expiry date
                        // Valid subscription
                        if isValidSubscription(expiryDate: expiryDate) {
                            // Valid subscription found
                            UserDefaults.standard.set(true, forKey: "userHasValidSubscription")
                            SubscriptionsCheck.shared.isValid = true
                            Loading.shared.shouldPresentLoading = false
                            // Broadcast success notification
                            // Purchase
                            if action == 1 {
                                DispatchQueue.main.async {
                                    NotificationCenter.default.post(name: SubscriptionNotifiations.purchaseRestoreSuccessfulNotification, object: nil)
                                }
                            }
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: SubscriptionNotifiations.didCheckSubscription, object: nil)
                                NotificationCenter.default.post(name: SubscriptionNotifiations.canPresentWalkthrough, object: nil)
                            }
                        }
                    }
                }
                // No valid subscription
                if !SubscriptionsCheck.shared.isValid {
                    // If no valid subscription found
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: SubscriptionNotifiations.restoreFailedNotification, object: nil)
                    }
                    UserDefaults.standard.set(false, forKey: "userHasValidSubscription")
                    SubscriptionsCheck.shared.isValid = false
                    Loading.shared.shouldPresentLoading = false
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: SubscriptionNotifiations.didCheckSubscription, object: nil)
                    }
                }
            }
        }
    }
    //
    // Check if subscription is valid
    func isValidSubscription(expiryDate: String) -> Bool {
        // Comes as ms since 1970, convert to s then to date
        let expiryDateS = Double(expiryDate)! / 1000
        //
        return Date().timeIntervalSince1970 < expiryDateS
    }
}


extension InAppManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            guard let productType = ProductType(rawValue: transaction.payment.productIdentifier) else {fatalError()}
            switch transaction.transactionState {
            case .purchasing:
                self.delegate?.inAppLoadingStarted()
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                // check
                let productIdentifier = transaction.payment.productIdentifier
                SwiftyReceiptValidator.validate(forIdentifier: productIdentifier, sharedSecret: InAppManager.accountSecret) { (success, response) in
                    if success {
                        InAppManager.shared.checkExpiryDateAction(response: response, action: 1)
                        // Her stuff
                        self.delegate?.inAppLoadingSucceded(productType: productType)
                        // nina
                    } else {
                        // Timed out/ failed
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: SubscriptionNotifiations.connectionTimedOutNotification, object: nil)
                        }
                    }
                    queue.finishTransaction(transaction)
                }
            case .failed:
                // Post cancelled notification
                if let transactionError = transaction.error as NSError?,
                    transactionError.code != SKError.paymentCancelled.rawValue {
                    self.delegate?.inAppLoadingFailed(error: transaction.error)
                    // Timed out/ failed
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: SubscriptionNotifiations.purchaseCancelledNotification, object: nil)
                    }
                } else {
                    // her stuff
                    self.delegate?.inAppLoadingFailed(error: InAppErrors.noSubscriptionPurchased)
                    // Post cancelled notification
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: SubscriptionNotifiations.purchaseCancelledNotification, object: nil)
                    }
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                // Transaction was restored from user's purchase history
                if let productIdentifier = transaction.original?.payment.productIdentifier {
                    // Validate receipt
                    SwiftyReceiptValidator.validate(forIdentifier: productIdentifier, sharedSecret: InAppManager.accountSecret) { (success, response) in
                        if success {
                            InAppManager.shared.checkExpiryDateAction(response: response, action: 1)
                            // Her stuff
                            SKPaymentQueue.default().finishTransaction(transaction)
                            self.delegate?.inAppLoadingSucceded(productType: productType)
                        } else {
                            // Timed out/ failed
                            DispatchQueue.main.async {
                                NotificationCenter.default.post(name: SubscriptionNotifiations.connectionTimedOutNotification, object: nil)
                            }
                        }
                        queue.finishTransaction(transaction)
                    }
                }
            case .deferred:
                self.delegate?.inAppLoadingSucceded(productType: productType)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: SubscriptionNotifiations.restoreFailedNotification, object: nil)
                }
            }
        }
    }

    // Restore failed with error
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Swift.Error) {
        //
        self.delegate?.inAppLoadingFailed(error: error)
        // Cancel transaction
//        print("Cancel Transaction / No Subscription Found")
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: SubscriptionNotifiations.restoreFailedNotification, object: nil)
        }
    }
    
    // Restore transaction finished -- failed?
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("Transaction Finished")
    }

}

//MARK: - SKProducatsRequestDelegate
extension InAppManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard response.products.count > 0 else {return}
        self.products = response.products
        // Notify that products have been loaded
        NotificationCenter.default.post(name: SubscriptionNotifiations.productsLoadedNotification, object: products)
    }
}
