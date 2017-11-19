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
    
    static let sessionIdSetNotification = Notification.Name("SubscriptionServiceSessionIdSetNotification")
    static let productsLoadedNotification = Notification.Name("SubscriptionServiceProductsLoadedNotification")
    static let restoreSuccessfulNotification = Notification.Name("SubscriptionServiceRestoreSuccessfulNotification")
    static let restoreFailedNotification = Notification.Name("SubscriptionServiceRestoreFailedNotification")
    static let restoreFinishedNotification = Notification.Name("SubscriptionServiceRestoreFinishedNotification")
    static let purchaseSuccessfulNotification = Notification.Name("SubscriptionServiceRestoreSuccessfulNotification")
    //
    static let didCheckSubscription = Notification.Name("DidCheckSubscriptionNotification")
    //
    static let connectionTimedOutNotification = Notification.Name("ConnectionTimedOutNotification")
}
