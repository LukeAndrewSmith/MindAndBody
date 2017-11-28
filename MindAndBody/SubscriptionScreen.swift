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
    var loadingView = UIView()
    
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load products
        InAppManager.shared.loadProducts()
        
        //
        NotificationCenter.default.addObserver(self, selector: #selector(handleOptionsLoaded(notification:)), name: SubscriptionNotifiations.productsLoadedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchaseSuccessfull(notification:)), name: SubscriptionNotifiations.purchaseSuccessfulNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeLoadingPresentError), name: SubscriptionNotifiations.connectionTimedOutNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchaseCancelled(notification:)), name: SubscriptionNotifiations.purchaseCancelledNotification, object: nil)
        
        //
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if InAppManager.shared.products == [] {
            addLoadingView()
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
            self?.loadingView.removeFromSuperview()
        }
    }
    
    @objc func handlePurchaseSuccessfull(notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.removeFromSuperview()
            self?.dismiss(animated: true)
        }
    }
    
    @objc func handlePurchaseCancelled(notification: Notification) {
        //
        // Tell the user they can cancel anytime
        let title = NSLocalizedString("canCancelTitle", comment: "")
        let message = NSLocalizedString("canCancelMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colours.colour2
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 19)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        
        // 'Oh go on then'
        let okAction = UIAlertAction(title:  NSLocalizedString("ohGoOnThen", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            if InAppManager.shared.products != [] {
                InAppManager.shared.purchaseProduct(productType: ProductType.yearly)
            } else {
                InAppManager.shared.loadProducts()
                DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: {
                    if InAppManager.shared.products == [] {
                        self.removeLoadingPresentError()
                    }
                })
            }
            //
        }
        
        // 'Yes im sure'
        let cancelAction = UIAlertAction(title:  NSLocalizedString("yesImSure", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            self.loadingView.removeFromSuperview()
        }
        
        // Add Actions
        alert.addAction(okAction)
        alert.addAction(cancelAction)

        // Present Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Load View
    func setupView() {
        UIApplication.shared.statusBarStyle = .lightContent
        //
        // BackgroundImage
//        view.backgroundColor = Colours.colour2
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
        
        // Page Control
        InfoPageControl.shared.setupPageControl(x: view.center.x, y: subscriptionButton.frame.minY - 12)
        view.addSubview(InfoPageControl.shared.pageControl)
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
    func addLoadingView() {
        // Setup Alert
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.72)
        loadingView.frame = UIScreen.main.bounds
        
        // Setup indicator
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.center = loadingView.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        loadingIndicator.color = Colours.colour1
        loadingIndicator.startAnimating()
        loadingView.addSubview(loadingIndicator)
        
        // Present Alert
        UIApplication.shared.keyWindow?.addSubview(loadingView)
    }
    

    @objc func removeLoadingPresentError() {
        loadingView.removeFromSuperview()
        self.presentErrorAlert()
    }
    
    // Loading
    func presentErrorAlert() {
        //
        // No connectio nmessage
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
                self.addLoadingView()
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
            addLoadingView()
            InAppManager.shared.purchaseProduct(productType: ProductType.yearly)
        } else {
            addLoadingView()
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
        addLoadingView()
        //
        NotificationCenter.default.addObserver(self, selector: #selector(SubscriptionScreen.dismissRestoreAlertSuccess), name: SubscriptionNotifiations.restoreSuccessfulNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SubscriptionScreen.failedToRestore), name: SubscriptionNotifiations.restoreFailedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SubscriptionScreen.dismissLoadingWhatever), name: SubscriptionNotifiations.restoreFinishedNotification, object: nil)
        //
        InAppManager.shared.restoreSubscription()
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: {
            if self.view.subviews.contains(self.loadingView) {
                self.removeLoadingPresentError()
            }
        })
    }
    
    @objc func dismissRestoreAlertSuccess() {
        loadingView.removeFromSuperview()
        self.dismiss(animated: true)
    }
    
    @objc func dismissLoadingWhatever() {
        loadingView.removeFromSuperview()
    }
    
    @objc func failedToRestore() {
        // Add alert saying failed to restore
        loadingView.removeFromSuperview()
        self.presentFailedToRestoreAlert()
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
        loadingView.removeFromSuperview()
        self.presentErrorAlert()
    }
    
}


class SubscriptionCell: UITableViewCell {
    
    
    //
    override func layoutSubviews() {
//        topLabel.text = "• Warmups \n• Workouts \n• Stretching"
//        topLabel.lineBreakMode = .byWordWrapping
    }
}
