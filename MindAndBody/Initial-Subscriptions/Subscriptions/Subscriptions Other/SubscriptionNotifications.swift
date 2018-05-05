//
//  SubscriptionNotifications.swift
//  MindAndBody
//
//  Created by Luke Smith on 18.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation


import StoreKit

class SubscriptionNotifiations: NSObject {
    
    static let sessionIdSetNotification = Notification.Name("SessionIdSetNotification")
    static let productsLoadedNotification = Notification.Name("ProductsLoadedNotification")
    static let restoreSuccessfulNotification = Notification.Name("RestoreSuccessfulNotification")
    static let restoreFailedNotification = Notification.Name("RestoreFailedNotification")
    static let restoreFinishedNotification = Notification.Name("RestoreFinishedNotification")
    static let purchaseSuccessfulNotification = Notification.Name("RestoreSuccessfulNotification")
    static let purchaseCancelledNotification = Notification.Name("PurchaseCancelledNotification")
    //
    static let didCheckSubscription = Notification.Name("DidCheckSubscriptionNotification")
    //
    static let connectionTimedOutNotification = Notification.Name("ConnectionTimedOutNotification")
}
