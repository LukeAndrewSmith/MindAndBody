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
        
        // Purchase/Restore success
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchaseRestoreAlertSuccess), name: SubscriptionNotifiations.purchaseRestoreSuccessfulNotification, object: nil)
        // Purchase
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchaseCancelled), name: SubscriptionNotifiations.purchaseCancelledNotification, object: nil)
        // Restore
        NotificationCenter.default.addObserver(self, selector: #selector(SubscriptionScreen.failedToRestore), name: SubscriptionNotifiations.restoreFailedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SubscriptionScreen.dismissLoadingWhatever), name: SubscriptionNotifiations.restoreFinishedNotification, object: nil)
        // Load options
        NotificationCenter.default.addObserver(self, selector: #selector(handleOptionsLoaded), name: SubscriptionNotifiations.productsLoadedNotification, object: nil)
        // Connection error
        NotificationCenter.default.addObserver(self, selector: #selector(removeLoadingPresentError), name: SubscriptionNotifiations.connectionTimedOutNotification, object: nil)
        //
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Setup views
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
    @objc func handleOptionsLoaded() {
        DispatchQueue.main.async { [weak self] in
            self?.setSubscriptionData()
            self?.loadingView.removeFromSuperview()
        }
    }
    
    @objc func handlePurchaseSuccessfull() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.removeFromSuperview()
            self?.dismiss(animated: true)
            NotificationCenter.default.post(name: SubscriptionNotifiations.canPresentWalkthrough, object: nil)
        }
    }
    
    @objc func handlePurchaseRestoreAlertSuccess() {
        loadingView.removeFromSuperview()
        self.dismiss(animated: true)
        NotificationCenter.default.post(name: SubscriptionNotifiations.canPresentWalkthrough, object: nil)
    }
    
    @objc func handlePurchaseCancelled() {
        //
        // Tell the user they can cancel anytime
        let title = NSLocalizedString("canCancelTitle", comment: "")
        let message = NSLocalizedString("canCancelMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
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
        
        okAction.setValue(Colors.green, forKey: "titleTextColor")
        cancelAction.setValue(Colors.red, forKey: "titleTextColor")
        
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
//        view.backgroundColor = Colors.dark
        addBackgroundImage(withBlur: true, fullScreen: true)
        //
        // Buttons
        // Profile
        subscriptionButton.setTitle(NSLocalizedString(NSLocalizedString("freeTrial", comment: ""), comment: ""), for: .normal)
        subscriptionButton.titleLabel?.lineBreakMode = .byWordWrapping
        subscriptionButton.titleLabel?.numberOfLines = 0
        subscriptionButton.titleLabel?.textAlignment = .center
        subscriptionButton.layer.cornerRadius = 15
        subscriptionButton.layer.masksToBounds = true
        subscriptionButton.backgroundColor = Colors.green.withAlphaComponent(0.25)
        checkSubscriptionButton.setTitle(NSLocalizedString("alreadyHaveSubscription", comment: ""), for: .normal)
        checkSubscriptionButton.backgroundColor = .clear
        
        // Page Control
        InfoPageControl.shared.setupPageControl(x: view.center.x, y: subscriptionButton.frame.minY - 12)
        view.addSubview(InfoPageControl.shared.pageControl)
    }
    
    // Load Subscription data
    func setSubscriptionData() {
        
        // TODO: NOT A VERY USEFUL FUNCTION
        //
//        let annual = InAppManager.shared.products[0]
        //
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.formatterBehavior = .behavior10_4
        //
//        let price = formatter.string(from: annual.price) ?? "\(annual.price)"
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
        loadingIndicator.color = Colors.light
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
        alert.view.tintColor = Colors.dark
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
        InAppManager.shared.restoreSubscription()
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: {
            if self.view.subviews.contains(self.loadingView) {
                self.removeLoadingPresentError()
            }
        })
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
        alert.view.tintColor = Colors.dark
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
