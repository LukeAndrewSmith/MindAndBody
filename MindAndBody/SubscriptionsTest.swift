//
//  SubscriptionsTest.swift
//  MindAndBody
//
//  Created by Luke Smith on 18.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.


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
    func subscriptionStatusUpdated(value: Bool)
}

class InAppManager: NSObject {
    static let shared = InAppManager()
    
    static let accountSecret = "a255263277c14664afb897c5de689810"

    weak var delegate: InAppManagerDelegate?

    var products: [SKProduct] = []

    var isTrialPurchased: Bool?
    var expirationDate: Date?
    var purchasedProduct: ProductType?

    var isSubscriptionAvailable: Bool = true
    {
        didSet(value) {
            self.delegate?.subscriptionStatusUpdated(value: value)
        }
    }

    func startMonitoring() {
        SKPaymentQueue.default().add(self)
        self.updateSubscriptionStatus()
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

    func checkSubscriptionAvailability() -> Bool {
        //
        loadProducts()
        let productIdentifier = "mind_and_body_yearly_subscription"
        //
        // Validate receipt
        var toReturn = false
        SwiftyReceiptValidator.validate(forIdentifier: productIdentifier, sharedSecret: InAppManager.accountSecret) { (success, response) in
            if success {
                toReturn = self.checkExpiryDateAction(response: response, action: 1)
            }
        }
        return toReturn
    }

    func updateSubscriptionStatus() {
        isSubscriptionAvailable = checkSubscriptionAvailability()
    }
    
    // MARK: Check reciept/expiry date
    //
    // reciptCheckAction
    func checkExpiryDateAction(response: [String: AnyObject]?, action: Int) -> Bool {
        /// Your code to restore product
        let receiptInfoFieldKey = SwiftyReceiptValidator.ResponseKey.latest_receipt_info.rawValue
        if let receipt = response![receiptInfoFieldKey] {
//        let receiptKey = SwiftyReceiptValidator.ResponseKey.receipt.rawValue
//        if let receipt = response![receiptKey] {
            // Check if subscription active
            let inAppKey = SwiftyReceiptValidator.InfoKey.in_app.rawValue
            if let inApp = receipt as? [AnyObject] {
                // Loop receipts
                for receiptInApp in inApp {
                    let expiryDateKey = SwiftyReceiptValidator.InfoKey.InApp.expires_date.rawValue
                    //
                    if let expiryDate = receiptInApp[expiryDateKey] as? Date {
                        // Check expiry date
                        if isValidSubscription(expiryDate: expiryDate) {
                            // Broadcast success notification 
                            if action == 0 {
                                DispatchQueue.main.async {
                                    NotificationCenter.default.post(name: SubscriptionNotifiations.restoreSuccessfulNotification, object: nil)
                                }
                            }
                            // If valid subscription found
                            return true
                        }
                    }
                }
            }
        }
        // If no valid subscription found
        return false
    }
    //
    // Check if subscription is valid
    func isValidSubscription(expiryDate: Date) -> Bool {
        return Date().timeIntervalSince1970 < expiryDate.timeIntervalSince1970
    }
    
//    func checkSubscriptionAvailability(_ completionHandler: @escaping (Bool) -> Void) {
//        guard let receiptUrl = Bundle.main.appStoreReceiptURL,
//            let receipt = try? Data(contentsOf: receiptUrl).base64EncodedString() as AnyObject else {
//                completionHandler(false)
//                return
//        }
//
//        let _ = Router.User.sendReceipt(receipt: receipt).request(baseUrl: "https:sandbox.itunes.apple.com").responseObject { (response: DataResponse<RTSubscriptionResponse>) in
//            switch response.result {
//            case .success(let value):
//                guard let expirationDate = value.expirationDate,
//                    let productId = value.productId else {completionHandler(false); return}
//                self.expirationDate = expirationDate
//                self.isTrialPurchased = value.isTrial
//                self.purchasedProduct = ProductType(rawValue: productId)
//                completionHandler(Date().timeIntervalSince1970 < expirationDate.timeIntervalSince1970)
//            case .failure(let error):
//                completionHandler(false)
//            }
//        }
//    }
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
                        InAppManager.shared.checkExpiryDateAction(response: response, action: 0)
                        // Her stuff
                        self.updateSubscriptionStatus()
                        self.isSubscriptionAvailable = true
                        self.delegate?.inAppLoadingSucceded(productType: productType)
                    }
                    queue.finishTransaction(transaction)
                }
            case .failed:
                if let transactionError = transaction.error as NSError?,
                    transactionError.code != SKError.paymentCancelled.rawValue {
                    self.delegate?.inAppLoadingFailed(error: transaction.error)
                    // Cancelled maybe?
                    // Reset expiring date
                    // TODO: HANDLE CANCEL????
                } else {
                    // her stuff
                    self.delegate?.inAppLoadingFailed(error: InAppErrors.noSubscriptionPurchased)
                    // Post failed notification
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: SubscriptionNotifiations.restoreFailedNotification, object: nil)
                    }
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                // Transaction was restored from user's purchase history
                if let productIdentifier = transaction.original?.payment.productIdentifier {
                    // Validate receipt
                    SwiftyReceiptValidator.validate(forIdentifier: productIdentifier, sharedSecret: InAppManager.accountSecret) { (success, response) in
                        if success {
                            InAppManager.shared.checkExpiryDateAction(response: response, action: 0)
                            // Her stuff
                            SKPaymentQueue.default().finishTransaction(transaction)
                            self.updateSubscriptionStatus()
                            self.isSubscriptionAvailable = true
                            self.delegate?.inAppLoadingSucceded(productType: productType)
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
        print("Cancel Transaction / No Subscription Found")
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: SubscriptionNotifiations.restoreFailedNotification, object: nil)
        }
    }
    
    // Restore transaction finished -- failed?
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("Transaction Finished")
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: SubscriptionNotifiations.restoreFinishedNotification, object: nil)
        }
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


//
//// Test
//class RTSubscriptionResponse: Mappable {
//    var expirationDate: Date?
//    var isTrial: Bool?
//    var productId: String?
//
//    required convenience init?(map: Map) {
//        self.init()
//    }
//
//    func mapping(map: Map) {
//        guard let latestReceiptInfo = (map.JSON["latest_receipt_info"] as? [[String: AnyObject]])?.first else {return}
//
//        if let expirationDateStringWithTimeZone = latestReceiptInfo["expires_date"] as? String,
//            let range = expirationDateStringWithTimeZone.range(of: "Etc/GMT") {
//            let expirationDateString = expirationDateStringWithTimeZone.substring(to: range.lowerBound)
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyy-MM-dd HH:mm:ss"
//            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//            self.expirationDate = dateFormatter.date(from: expirationDateString)
//        }
//        self.isTrial = Bool(latestReceiptInfo["is_trial_period"] as? String ?? "false")
//        self.productId = latestReceiptInfo["product_id"] as? String
//    }
//}
//
