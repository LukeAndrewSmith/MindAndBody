//
//  SubscriptionScreen.swift
//  MindAndBody
//
//  Created by Luke Smith on 18.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class SubscriptionScreen: UIViewController {
    
    //
    // Outlets
    @IBOutlet weak var subscriptionButton: UIButton!
    @IBOutlet weak var checkSubscriptionButton: UIButton!
    
    // Loading
    var loadingAlert = UIAlertController()
    
    
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load products
        InAppManager.shared.loadProducts()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleOptionsLoaded(notification:)), name: SubscriptionNotifiations.productsLoadedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchaseSuccessfull(notification:)), name: SubscriptionNotifiations.purchaseSuccessfulNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeLoadingPresentError), name: SubscriptionNotifiations.connectionTimedOutNotification, object: nil)
        
        //
        loadMyView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if InAppManager.shared.products == [] {
            addLoadingAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: {
                if InAppManager.shared.products == [] {
                    self.removeLoadingPresentError()
                }
            })
        } else {
            setSubscriptionData()
        }
    }
    
    // Subscription handlers
    @objc func handleOptionsLoaded(notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.setSubscriptionData()
            self?.removeLoadingAlert()
        }
    }
    
    @objc func handlePurchaseSuccessfull(notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    // MARK: Load View
    func loadMyView() {
        UIApplication.shared.statusBarStyle = .lightContent
        //
        // BackgroundImage
        addBackgroundImage(withBlur: true, fullScreen: true)
        //
        // Buttons
        // Profile
        subscriptionButton.setTitle(NSLocalizedString(NSLocalizedString("freeTrial", comment: ""), comment: ""), for: .normal)
        subscriptionButton.titleLabel?.lineBreakMode = .byWordWrapping
        subscriptionButton.titleLabel?.numberOfLines = 0
        subscriptionButton.titleLabel?.textAlignment = .center
        subscriptionButton.layer.cornerRadius = 15
//            subscriptionButton.bounds.height / 2
        subscriptionButton.layer.masksToBounds = true
        subscriptionButton.backgroundColor = Colours.colour3.withAlphaComponent(0.25)
        checkSubscriptionButton.setTitle(NSLocalizedString("alreadyHaveSubscription", comment: ""), for: .normal)
//        checkSubscriptionButton.layer.cornerRadius = checkSubscriptionButton.bounds.height / 2
//        checkSubscriptionButton.layer.masksToBounds = true
        checkSubscriptionButton.backgroundColor = .clear
//            Colours.colour1.withAlphaComponent(0.25)
    }
    
    // Load Subscription data
    func setSubscriptionData() {
        //
        let annual = InAppManager.shared.products[0]
        //
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .behavior10_4
        //
        let price = formatter.string(from: annual.price) ?? "\(annual.price)"
        //
//        self.subscriptionButton.setTitle(price + NSLocalizedString("perYear", comment: ""), for: .normal)
    }
    
    // MARK: Alerts
    // Loading
    func addLoadingAlert() {
        // Setup Alert
        loadingAlert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
        
        // Setup indicator
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating()
        
        loadingAlert.view.addSubview(loadingIndicator)
        
        // Present Alert
        self.present(loadingAlert, animated: true, completion: nil)
    }
    
    //
    func removeLoadingAlert() {
        loadingAlert.dismiss(animated: true)
    }
    
    @objc func removeLoadingPresentError() {
        loadingAlert.dismiss(animated: true) {
            self.presentErrorAlert()
        }
    }
    
    // Loading
    func presentErrorAlert() {
        //
        // Alert View indicating meaning of resetting the app
        let title = NSLocalizedString("subscriptionWarning", comment: "")
        let message = NSLocalizedString("subscriptionWarningMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colours.colour2
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 19)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        
        // Reset app action
        let okAction = UIAlertAction(title:  NSLocalizedString("userCheckedConnection", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            if InAppManager.shared.products == [] {
                self.addLoadingAlert()
                InAppManager.shared.loadProducts()
                DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: {
                    if InAppManager.shared.products == [] {
                        self.removeLoadingPresentError()
                    }
                })
            }
        }
        // Add Actions
        alert.addAction(okAction)
        
        // Present Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //
    // MARK: Info table
    var infoSections: [String] =
        [" ", ""]
    var infoBulletPoints: [[String]] =
        [
            // Overview
            ["subscription1", "subscription2", "subscription3", "", "termsAndConditions"],
            // Terms & Conditions
            ["termsAndConditionsDetail"]
    ]
    
    //
    // MARK: Button Handlers
    // Subscription button
    @IBAction func subscriptionButtonAction(_ sender: Any) {
        if InAppManager.shared.products != [] {
            InAppManager.shared.purchaseProduct(productType: ProductType.yearly)
        } else {
            addLoadingAlert()
            InAppManager.shared.loadProducts()
            DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: {
                if InAppManager.shared.products == [] {
                    self.removeLoadingPresentError()
                }
            })
        }
    }
    
    //
    // Look around app button
    @IBAction func restoreButton(_ sender: Any) {
        //
        addLoadingAlert()
        //
        NotificationCenter.default.addObserver(self, selector: #selector(SubscriptionScreen.dismissRestoreAlertSuccess), name: SubscriptionNotifiations.restoreSuccessfulNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SubscriptionScreen.failedToRestore), name: SubscriptionNotifiations.restoreFailedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SubscriptionScreen.dismissLoadingWhatever), name: SubscriptionNotifiations.restoreFinishedNotification, object: nil)
        //
        InAppManager.shared.restoreSubscription()
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: {
            if self.loadingAlert.isBeingPresented {
                self.removeLoadingPresentError()
            }
        })
    }
    
    @objc func dismissRestoreAlertSuccess() {
        loadingAlert.dismiss(animated: true) {
            self.dismiss(animated: true)
        }
    }
    
    @objc func dismissLoadingWhatever() {
        loadingAlert.dismiss(animated: true)
    }
    
    @objc func failedToRestore() {
        // Add alert saying failed to restore
        loadingAlert.dismiss(animated: true, completion: {
            self.presentFailedToRestoreAlert()
        })
        //
    }
    
    func presentFailedToRestoreAlert() {
        //
        // Alert View indicating meaning of resetting the app
        let title = NSLocalizedString("restoreWarning", comment: "")
        let message = NSLocalizedString("restoreWarningMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colours.colour2
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 19)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        
        // Reset app action
        let okAction = UIAlertAction(title:  NSLocalizedString("ok", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        // Add Actions
        alert.addAction(okAction)
        
        // Present Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //
    // Timed out
    func timedOut() {
        loadingAlert.dismiss(animated: true) {
            self.presentErrorAlert()
        }
    }
    
}


class SubscriptionCell: UITableViewCell {
    
    
    //
    override func layoutSubviews() {
//        topLabel.text = "• Warmups \n• Workouts \n• Stretching"
//        topLabel.lineBreakMode = .byWordWrapping
    }
}
