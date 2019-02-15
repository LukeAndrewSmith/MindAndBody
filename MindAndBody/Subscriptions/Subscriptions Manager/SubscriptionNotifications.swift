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
    static let productsFailedToLoad = Notification.Name("ProductsFailedToLoad")
    static let restoreFailedNotification = Notification.Name("RestoreFailedNotification")
    static let restoreFinishedNotification = Notification.Name("RestoreFinishedNotification")
    static let dismissLoading = Notification.Name("DismissLoading")
    static let purchaseRestoreSuccessfulNotification = Notification.Name("PurchaseRestoreSuccessfulNotification")
    static let purchaseFailedNotification = Notification.Name("PurchaseFailedNotification")
    //
    static let connectionTimedOutNotification = Notification.Name("ConnectionTimedOutNotification")
    //
    static let didCheckSubscription = Notification.Name("DidCheckSubscriptionNotification")
    static let canPresentWalkthrough = Notification.Name("CanPresentWalkthrough")
}
