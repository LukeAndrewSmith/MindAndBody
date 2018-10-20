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
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleImageHeight: NSLayoutConstraint!
    @IBOutlet weak var infoPageView: UIView!
    @IBOutlet weak var tryForFreeView: UIView!
    @IBOutlet weak var subscriptionButton: UIButton!
    @IBOutlet weak var checkSubscriptionButton: UIButton!
    
    //
//    let subscriptionChoiceView = UIView()
    let subscriptionChoiceBackground = UIButton()
//    let threeMonthsButton = UIButton()
//    let twelveMonthsButton = UIButton()
//    let priceLabel = UILabel()
//    let pricePerWeekLabel = UILabel()
//    let beginFreeTrialButton = UIButton()
    @IBOutlet weak var subscriptionChoiceViewTop: NSLayoutConstraint!
    @IBOutlet weak var subscriptionChoiceView: UIView!
    //
    @IBOutlet weak var threeMonthsView: UIView!
    @IBOutlet weak var threeMonthsTitle: UILabel!
    @IBOutlet weak var threeMonthsWeek: UILabel!
    @IBOutlet weak var threeMonthsTotal: UILabel!
    //
    @IBOutlet weak var twelveMonthsView: UIView!
    @IBOutlet weak var twelveMonthsTitle: UILabel!
    @IBOutlet weak var twelveMonthsWeek: UILabel!
    @IBOutlet weak var twelveMonthsTotal: UILabel!
    
    
    @IBOutlet weak var extraInfoLabel: UILabel!
    
    var didSetup = false
    
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
        if !didSetup {
            didSetup = true
            setupView()
            setupTitleImage()
            setupSubscriptionChoiceView()
        }
    }
    
    func setupTitleImage() {
        infoPageView.backgroundColor = .clear
        titleImageHeight.constant = (infoPageView.frame.height * (4/9)) + ElementHeights.statusBarHeight
        titleImage.image = #imageLiteral(resourceName: "GroupMeditation")
        titleImage.contentMode = .scaleAspectFill
        titleImage.clipsToBounds = true
    }
    
    func setupSubscriptionChoiceView() {
        
        let viewMaxY = tryForFreeView.frame.maxY + ElementHeights.bottomSafeAreaInset
        subscriptionChoiceView.backgroundColor = Colors.dark
        subscriptionChoiceView.frame.size = CGSize(width: view.bounds.width, height: 88 * 3)
//            viewMaxY-titleImageHeight.constant)
        subscriptionChoiceViewTop.constant = tryForFreeView.frame.maxY + ElementHeights.bottomSafeAreaInset
        self.view.layoutIfNeeded()
//        subscriptionChoiceView.frame.origin = CGPoint(x: 0, y: tryForFreeView.frame.maxY + ElementHeights.bottomSafeAreaInset)
//        subscriptionChoiceView.backgroundColor = Colors.green
//        view.addSubview(subscriptionChoiceView)
//        view.bringSubview(toFront: subscriptionChoiceView)
        
//        let cancelButton = UIButton()
//        cancelButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
//        cancelButton.setImage(#imageLiteral(resourceName: "Cross"), for: .normal)
//        cancelButton.tintColor = Colors.red
//        cancelButton.addTarget(self, action: #selector(cancelSubscriptionChoice), for: .touchUpInside)
//        subscriptionChoiceView.addSubview(cancelButton)
        

//        threeMonthsButton.setTitle(NSLocalizedString("3 Months", comment: ""), for: .normal)
//        threeMonthsButton.setTitleColor(Colors.light, for: .normal)
//        threeMonthsButton.titleLabel?.font = UIFont(name: "SFUIDisplay-regular", size: 20)
//        threeMonthsButton.titleLabel?.textAlignment = .center
//        threeMonthsButton.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: 44)
//        subscriptionChoiceView.addSubview(threeMonthsButton)
//
//
//        twelveMonthsButton.setTitle("12 Months", for: .normal)
//        twelveMonthsButton.setTitleColor(Colors.light, for: .normal)
//        twelveMonthsButton.titleLabel?.font = UIFont(name: "SFUIDisplay-regular", size: 20)
//        twelveMonthsButton.titleLabel?.textAlignment = .center
//        twelveMonthsButton.frame = CGRect(x: view.bounds.width / 2, y: 0, width: view.bounds.width / 2, height: 44)
//        subscriptionChoiceView.addSubview(twelveMonthsButton)
        
        
//        let underline = UIView()
//        underline.frame = CGRect(x: view.bounds.width / 2, y: twelveMonthsButton.frame.maxY, width: view.bounds.width / 2, height: 2)
//        underline.backgroundColor = Colors.light
//        subscriptionChoiceView.addSubview(underline)
        
        
//        priceLabel.frame = CGRect(x: 16, y: subscriptionChoiceView.bounds.height * (1/3) - 22, width: view.bounds.width - 32, height: 44)
//        priceLabel.text = NSLocalizedString("CHF 20 / 12 Months", comment: "")
//        priceLabel.font = UIFont(name: "SFUIDisplay-regular", size: 20)
//        priceLabel.textColor = Colors.light
//        subscriptionChoiceView.addSubview(priceLabel)
//
//
//        beginFreeTrialButton.frame = CGRect(x: 16, y: subscriptionChoiceView.bounds.height * (3/4) - 22, width: view.bounds.width - 32, height: 44)
//        beginFreeTrialButton.backgroundColor = Colors.green.withAlphaComponent(0.27)
//        beginFreeTrialButton.setTitle("Begin 1 month Free Trial", for: .normal)
//        beginFreeTrialButton.titleLabel?.font = UIFont(name: "SFUIDisplay-regular", size: 23)
//        beginFreeTrialButton.layer.cornerRadius = 11
//        beginFreeTrialButton.clipsToBounds = true
//        subscriptionChoiceView.addSubview(beginFreeTrialButton)

        
        threeMonthsView.backgroundColor = Colors.dark
        threeMonthsView.layer.borderColor = Colors.darkGray.cgColor
        threeMonthsView.layer.borderWidth = 1
        threeMonthsView.layer.cornerRadius = 4
        threeMonthsView.addShadow()
        threeMonthsView.layer.shadowColor = UIColor.black.cgColor
        
        threeMonthsTitle.textColor = Colors.light
        threeMonthsWeek.textColor = Colors.light
        threeMonthsTotal.textColor = Colors.light
        
        
        twelveMonthsView.backgroundColor = Colors.dark
        twelveMonthsView.layer.borderColor = Colors.green.cgColor
        twelveMonthsView.layer.borderWidth = 1
        twelveMonthsView.layer.cornerRadius = 4
        twelveMonthsView.addShadow()
        twelveMonthsView.layer.shadowColor = UIColor.black.cgColor
        
        twelveMonthsTitle.textColor = Colors.light
        twelveMonthsWeek.textColor = Colors.light
        twelveMonthsTotal.textColor = Colors.light
        
        
//        infoLabel.frame = CGRect(x: 16, y: beginFreeTrialButton.bounds.maxY, width: view.bounds.width - 32, height: view.frame.maxY - beginFreeTrialButton.frame.maxY)
        extraInfoLabel.text = NSLocalizedString("Buying the subscription will grant you access to the app and all its features for the selected time frame. The subscription will automatically renew within 24 hours of the end of the selected time unless cancelled. You can manage your subscriptions in Account Settings. By purchasing the subscription through in-app subscription, you agree to the Apple App Store terms and conditions. Visit our Terms of Use and Privacy Policy to learn more.", comment: "")
        extraInfoLabel.font = UIFont(name: "SFUIDisplay-regular", size: 11)
        extraInfoLabel.textColor = Colors.darkGray
        
        
        subscriptionChoiceBackground.frame = UIScreen.main.bounds
        subscriptionChoiceBackground.backgroundColor = Colors.dark.withAlphaComponent(0)
        subscriptionChoiceBackground.addTarget(self, action: #selector(cancelSubscriptionChoice), for: .touchUpInside)
    }
    
    @objc func cancelSubscriptionChoice() {
        animateSubscriptionChoice(up: false)
    }
    
    func animateSubscriptionChoice(up: Bool) {
        
        let viewMaxY = tryForFreeView.frame.maxY + ElementHeights.bottomSafeAreaInset
        
        if up {
            
            subscriptionChoiceViewTop.constant = viewMaxY - self.subscriptionChoiceView.frame.height
            view.insertSubview(subscriptionChoiceBackground, belowSubview: subscriptionChoiceView)
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: {
                
                self.subscriptionChoiceBackground.backgroundColor = Colors.dark.withAlphaComponent(0.5)
                self.view.layoutIfNeeded()
//                self.subscriptionChoiceView.frame.origin = CGPoint(x: 0, y: viewMaxY - self.subscriptionChoiceView.frame.height)
            }, completion: nil)
            
        } else {
            
            subscriptionChoiceViewTop.constant = viewMaxY
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
//                self.subscriptionChoiceView.frame.origin = CGPoint(x: 0, y: viewMaxY)
                self.subscriptionChoiceBackground.backgroundColor = Colors.dark.withAlphaComponent(0)
            }, completion: { finished in
                self.subscriptionChoiceBackground.removeFromSuperview()
            })
        }
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
        view.backgroundColor = Colors.light
        tryForFreeView.backgroundColor = Colors.dark
//        addBackgroundImage(withBlur: true, fullScreen: true, image: "")

        // Buttons
        // Profile
        subscriptionButton.setTitle(NSLocalizedString(NSLocalizedString("freeTrial", comment: ""), comment: ""), for: .normal)
        subscriptionButton.titleLabel?.lineBreakMode = .byWordWrapping
        subscriptionButton.titleLabel?.numberOfLines = 0
        subscriptionButton.titleLabel?.textAlignment = .center
//        subscriptionButton.layer.cornerRadius = 15
//        subscriptionButton.layer.masksToBounds = true
        subscriptionButton.backgroundColor = Colors.green.withAlphaComponent(0.43)
        checkSubscriptionButton.setTitle(NSLocalizedString("alreadyHaveSubscription", comment: ""), for: .normal)
        checkSubscriptionButton.backgroundColor = .clear
        
        // Page Control
        InfoPageControl.shared.setupPageControl(x: view.center.x, y: infoPageView.frame.maxY)
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
            animateSubscriptionChoice(up: true)
//            addLoadingView()
//            InAppManager.shared.purchaseProduct(productType: ProductType.yearly)
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
