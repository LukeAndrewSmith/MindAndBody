//
//  SubscriptionScreen.swift
//  MindAndBody
//
//  Created by Luke Smith on 18.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class SubscriptionScreen: UIViewController, UITextViewDelegate {
    
    // Outlets
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleImageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var subscriptionButton: UIButton!
    @IBOutlet weak var noSubscriptionButton: UIButton!
    @IBOutlet weak var checkSubscriptionButton: UIButton!
    @IBOutlet weak var subscriptionButtonsBackground: UIView!
    
    @IBOutlet weak var subscriptionTitle: UILabel!
    @IBOutlet weak var separatorView: UIView!
    var subscriptionText = UILabel()
    @IBOutlet weak var subscriptionTextScroll: UIScrollView!
    
    
    
    // Subscription purchase popup
    let subscriptionChoiceBackground = UIButton()
    @IBOutlet weak var subscriptionChoiceViewTop: NSLayoutConstraint!
    @IBOutlet weak var subscriptionChoiceView: UIView!
    @IBOutlet weak var subscriptionChoiceViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var subscriptionsViewStack: UIStackView!
    
    @IBOutlet weak var threeMonthButton: UIButton!
    @IBOutlet weak var threeMonthsView: UIView!
    @IBOutlet weak var threeMonthsTitle: UILabel!
    @IBOutlet weak var threeMonthsWeek: UILabel!
    @IBOutlet weak var threeMonthsTotal: UILabel!

    @IBOutlet weak var twelveMonthButton: UIButton!
    @IBOutlet weak var twelveMonthsView: UIView!
    @IBOutlet weak var twelveMonthsTitle: UILabel!
    @IBOutlet weak var twelveMonthsWeek: UILabel!
    @IBOutlet weak var twelveMonthsTotal: UILabel!
    
    @IBOutlet weak var extraInfoLabel: UILabel!
    @IBOutlet weak var linkView: UITextView!
    
    var loadingView = UIView()
    var didSetup = false
    
    let url = URL(string: "https://mind-and-body.info")!

    // -------------------------------------------------------------
    // MARK:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationHandlers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Setup views
        if !didSetup {
            didSetup = true
            setupView()
            setupTitleImage()
            setupSubscriptionInfo()
            setupSubscriptionChoiceView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Loading products
        if InAppManager.shared.products.count == 0 {
            addLoadingView()
        }
    }
    
    // -------------------------------------------------------------
    // MARK:- Setup
    
    func setupNotificationHandlers() {
        // Purchase/Restore success
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchaseRestoreAlertSuccess), name: SubscriptionNotifiations.purchaseRestoreSuccessfulNotification, object: nil)
        // Dismiss loading
        NotificationCenter.default.addObserver(self, selector: #selector(dismissLoadingWhatever), name: SubscriptionNotifiations.dismissLoading, object: nil)
        // Purchase failed
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchaseFailed), name: SubscriptionNotifiations.purchaseFailedNotification, object: nil)
        // Restore
        NotificationCenter.default.addObserver(self, selector: #selector(SubscriptionScreen.failedToRestore), name: SubscriptionNotifiations.restoreFailedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SubscriptionScreen.dismissLoadingWhatever), name: SubscriptionNotifiations.restoreFinishedNotification, object: nil)
        // Load options
        NotificationCenter.default.addObserver(self, selector: #selector(handleOptionsLoaded), name: SubscriptionNotifiations.productsLoadedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleProductsFailed), name: SubscriptionNotifiations.productsFailedToLoad, object: nil)
        // Connection error
        NotificationCenter.default.addObserver(self, selector: #selector(removeLoadingPresentError), name: SubscriptionNotifiations.connectionTimedOutNotification, object: nil)
    }
    
    // MARK: Load View
    func setupView() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        // BackgroundImage
        view.backgroundColor = Colors.light
        
        /// Subscription
        subscriptionButton.setTitle(NSLocalizedString(NSLocalizedString("supportMindBody", comment: ""), comment: ""), for: .normal)
        subscriptionButton.titleLabel?.font = UIFont(name: "SFUIDisplay-bold", size: 27)
        subscriptionButton.titleLabel?.lineBreakMode = .byWordWrapping
        subscriptionButton.titleLabel?.numberOfLines = 0
        subscriptionButton.titleLabel?.textAlignment = .center
        subscriptionButton.setTitleColor(Colors.light, for: .normal)
        subscriptionButton.backgroundColor = Colors.green.withAlphaComponent(0.72)
        
        /// No Subscription
        noSubscriptionButton.setTitle(NSLocalizedString(NSLocalizedString("noThanks", comment: ""), comment: ""), for: .normal)
        noSubscriptionButton.titleLabel?.font = UIFont(name: "SFUIDisplay-bold", size: 23)
        noSubscriptionButton.titleLabel?.lineBreakMode = .byWordWrapping
        noSubscriptionButton.titleLabel?.numberOfLines = 0
        noSubscriptionButton.titleLabel?.textAlignment = .center
        noSubscriptionButton.setTitleColor(Colors.light, for: .normal)
        noSubscriptionButton.backgroundColor = Colors.red.withAlphaComponent(0.72)
        
        /// Check Subscription
        checkSubscriptionButton.setTitle(NSLocalizedString("alreadyHaveSubscription", comment: ""), for: .normal)
        checkSubscriptionButton.backgroundColor = Colors.dark
    }
    
    func setupTitleImage() {
        titleImageHeight.constant = (view.bounds.height  * (1/4)) + ElementHeights.statusBarHeight
        titleImage.image = #imageLiteral(resourceName: "GroupMeditation")
        titleImage.contentMode = .scaleAspectFill
        titleImage.clipsToBounds = true
    }
    
    func setupSubscriptionInfo() {
        subscriptionTitle.font = UIFont(name: "SFUIDisplay-regular", size: 30)
        subscriptionTitle.text = NSLocalizedString("supportMindBody", comment: "")
        subscriptionTitle.contentMode = .bottomLeft
        
        subscriptionText.font = UIFont(name: "SFUIDisplay-light", size: 19)
        subscriptionText.text = NSLocalizedString("supportMindBodyText", comment: "")
        subscriptionText.lineBreakMode = .byWordWrapping
        subscriptionText.contentMode = .topLeft
        subscriptionText.numberOfLines = 0
        subscriptionText.frame = CGRect(x: 0, y: 0, width: subscriptionTextScroll.bounds.width, height: 0)
        subscriptionText.sizeToFit()
        
        subscriptionTextScroll.addSubview(subscriptionText)
        subscriptionTextScroll.contentSize = CGSize(width: subscriptionTextScroll.bounds.width, height: subscriptionText.bounds.height + 20)
        subscriptionTextScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        separatorView.backgroundColor = Colors.dark.withAlphaComponent(0.27)
        subscriptionButtonsBackground.backgroundColor = Colors.dark
    }
    
    func setupSubscriptionChoiceView() {
        
        /// Ensure data is set
        setSubscriptionData()
        
        subscriptionChoiceView.backgroundColor = Colors.dark
        subscriptionChoiceView.frame.size = CGSize(width: view.bounds.width, height: 88 * 3)
        subscriptionChoiceViewTop.constant = checkSubscriptionButton.frame.maxY + ElementHeights.bottomSafeAreaInset
        self.view.layoutIfNeeded()
        
        // Three Months ------------------------------
        threeMonthsView.backgroundColor = Colors.dark
        threeMonthsView.layer.borderColor = Colors.darkGray.cgColor
        threeMonthsView.layer.borderWidth = 2
        threeMonthsView.layer.cornerRadius = 4
        threeMonthsView.addShadow()
        threeMonthsView.layer.shadowColor = UIColor.black.cgColor
        
        threeMonthsTitle.text = NSLocalizedString("threeMonthsTitle", comment: "")
        threeMonthsTitle.font = UIFont(name: "SFUIDisplay-semibold", size: 21)
        threeMonthsTitle.textColor = Colors.light
        
        threeMonthsWeek.font = UIFont(name: "SFUIDisplay-semibold", size: 18)
        threeMonthsWeek.textColor = Colors.light
        
        threeMonthsTotal.font = UIFont(name: "SFUIDisplay-regular", size: 15)
        threeMonthsTotal.textColor = Colors.gray
        
        // Twelve Months ------------------------------
        twelveMonthsView.backgroundColor = Colors.dark
        twelveMonthsView.layer.borderColor = Colors.green.cgColor
        twelveMonthsView.layer.borderWidth = 2
        twelveMonthsView.layer.cornerRadius = 4
        twelveMonthsView.addShadow()
        twelveMonthsView.layer.shadowColor = UIColor.black.cgColor
        
        twelveMonthsTitle.text = NSLocalizedString("twelveMonthsTitle", comment: "")
        twelveMonthsTitle.font = UIFont(name: "SFUIDisplay-semibold", size: 21)
        twelveMonthsTitle.textColor = Colors.light
        
        twelveMonthsWeek.font = UIFont(name: "SFUIDisplay-semibold", size: 18)
        twelveMonthsWeek.textColor = Colors.light
        
        twelveMonthsTotal.font = UIFont(name: "SFUIDisplay-regular", size: 15)
        twelveMonthsTotal.textColor = Colors.gray
        
        // Extra Info ---------------------
        extraInfoLabel.text = NSLocalizedString("extraInfoSub", comment: "")
        extraInfoLabel.font = UIFont(name: "SFUIDisplay-regular", size: 11)
        extraInfoLabel.textColor = Colors.darkGray
        
        // Link ---------------------
        let linkAttributes = [
            .link: url,
            .font: UIFont(name: "SFUIDisplay-regular", size: 11)!,
            .foregroundColor: Colors.light,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ] as [NSAttributedString.Key : Any]
        let attributedString = NSMutableAttributedString(string: NSLocalizedString("termsAndPrivacyLink", comment: ""))
        let count = NSLocalizedString("termsAndPrivacyLink", comment: "").count
        attributedString.addAttribute(.foregroundColor, value: Colors.light , range: NSMakeRange(0, count))
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(0, count))
        linkView.attributedText = attributedString
        linkView.isEditable = false
        linkView.dataDetectorTypes = .link
        linkView.delegate = self
        
        // Height -------------------------
        subscriptionsViewStack.layoutIfNeeded()
        subscriptionChoiceViewHeight.constant = 24 + subscriptionsViewStack.bounds.height + linkView.bounds.height + 8
            
        // Background Button -------------------------
        subscriptionChoiceBackground.frame = UIScreen.main.bounds
        subscriptionChoiceBackground.backgroundColor = Colors.dark.withAlphaComponent(0)
        subscriptionChoiceBackground.addTarget(self, action: #selector(cancelSubscriptionChoice), for: .touchUpInside)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if (URL == url) {
            UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        }
        return false
    }
    
    // -------------------------------------------------------------
    
    // Subscription handlers
    @objc func handleOptionsLoaded() {
        setSubscriptionData()
        loadingView.removeFromSuperview()
    }
    
    // Use Subscription data
    func setSubscriptionData() {

        guard InAppManager.shared.products.count == ProductType.all.count else { return }
        
        var threeMonth = InAppManager.shared.products[0]
        var yearly = InAppManager.shared.products[1]
        
        // Check that we accessed the products the correct way round
        if InAppManager.shared.products[0].productIdentifier == ProductType.yearly.rawValue {
            threeMonth = InAppManager.shared.products[1]
            yearly = InAppManager.shared.products[0]
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .behavior10_4
        formatter.locale = yearly.priceLocale
    
        // Three months ----
        let threeMonthPrice = formatter.string(from: threeMonth.price) ?? "\(threeMonth.price)"
        
        let threeMonthDividor = NSDecimalNumber(mantissa: 12, exponent: 0, isNegative: false)
        let threeMonthWeeklyPrice = threeMonth.price.dividing(by: threeMonthDividor)
        let threeMonthPriceWeekly = formatter.string(from: threeMonthWeeklyPrice) ?? "\(threeMonthWeeklyPrice)"
        
        // Yearly -------
        let yearlyPrice = formatter.string(from: yearly.price) ?? "\(yearly.price)"
        
        let yearlyDividor = NSDecimalNumber(mantissa: 52, exponent: 0, isNegative: false)
        let yearlyWeeklyPrice = yearly.price.dividing(by: yearlyDividor)
        let yearlyPriceWeekly = formatter.string(from: yearlyWeeklyPrice) ?? "\(yearlyWeeklyPrice)"
        
        threeMonthsWeek.text = threeMonthPriceWeekly + NSLocalizedString("perWeek", comment: "")
        threeMonthsTotal.text = NSLocalizedString("billedAs", comment: "") + threeMonthPrice + NSLocalizedString("per3Months", comment: "")
        
        twelveMonthsWeek.text = yearlyPriceWeekly + NSLocalizedString("perWeek", comment: "")
        twelveMonthsTotal.text = NSLocalizedString("billedAs", comment: "") + yearlyPrice + NSLocalizedString("per12Months", comment: "")
    }
    
    
    // -------------------------------------------------------------
    // MARK: Subscriptions view
    
    // Present Subscriptions button
    @IBAction func subscriptionButtonAction(_ sender: Any) {
        if InAppManager.shared.products != [] {
            setupSubscriptionChoiceView()
            animateSubscriptionChoice(up: true)
        } else {
            addLoadingView()
            InAppManager.shared.loadProducts()
            print("Loading Products")
        }
    }
    
    @objc func cancelSubscriptionChoice() {
        animateSubscriptionChoice(up: false)
    }
    
    func animateSubscriptionChoice(up: Bool) {
        
        let viewMaxY = checkSubscriptionButton.frame.maxY // ElementHeights.bottomSafeAreaInset
        
        if up {
            subscriptionChoiceViewTop.constant = viewMaxY - subscriptionChoiceViewHeight.constant
            view.insertSubview(subscriptionChoiceBackground, belowSubview: subscriptionChoiceView)
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: {
                
                self.subscriptionChoiceBackground.backgroundColor = Colors.dark.withAlphaComponent(0.5)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            subscriptionChoiceViewTop.constant = viewMaxY
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
                self.subscriptionChoiceBackground.backgroundColor = Colors.dark.withAlphaComponent(0)
            }, completion: { finished in
                self.subscriptionChoiceBackground.removeFromSuperview()
            })
        }
    }
    
    @IBAction func noSubscriptionButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    // -------------------------------------------------------------
    // MARK:- Purchase
    
    @IBAction func threeMonthButtonAction(_ sender: Any) {
        addLoadingView()
        if !InAppManager.shared.purchaseProduct(productType: ProductType.threeMonth) {
            dismissLoadingWhatever()
            purchaseDenied()
        }
    }
    
    @IBAction func twelveMonthButtonAction(_ sender: Any) {
        addLoadingView()
        if !InAppManager.shared.purchaseProduct(productType: ProductType.yearly) {
            dismissLoadingWhatever()
            purchaseDenied()
        }
    }
    
    @objc func handlePurchaseRestoreAlertSuccess() {
        loadingView.removeFromSuperview()
        self.dismiss(animated: true)
    }
    
    
    // -------------------------------------------------------------
    // MARK:- Restore
    // Restore
    @IBAction func restoreButton(_ sender: Any) {
        addLoadingView()
        InAppManager.shared.restoreSubscription()
    }

    // -------------------------------------------------------------
    // MARK:- Errors
    @objc func handleProductsFailed() {
        // Tell the user the products failed to load with the given apple error message,
        let title = NSLocalizedString("productsFailedTitle", comment: "")
        let message = NSLocalizedString(InAppManager.shared.productsFailedError, comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-semibold", size: 19)!]), forKey: "attributedTitle")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-regular", size: 17)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        // 'Ok'
        let okAction = UIAlertAction(title:  NSLocalizedString("retry", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            InAppManager.shared.loadProducts()
        }
        
        // Add Actions
        alert.addAction(okAction)
        
        // Present Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func handlePurchaseFailed() {
        dismissLoadingWhatever()
        // Tell the user they can cancel anytime
        let title = NSLocalizedString("purchaseFailedTitle", comment: "")
        let message = NSLocalizedString("purchaseFailedText", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-semibold", size: 19)!]), forKey: "attributedTitle")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-regular", size: 17)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        // 'Ok'
        let okAction = UIAlertAction(title:  NSLocalizedString("ok", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            
        }
        
        // Add Actions
        alert.addAction(okAction)
        
        // Present Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func purchaseDenied() {
        // Tell the user they can cancel anytime
        let title = NSLocalizedString("purchaseDeniedTitle", comment: "")
        let message = NSLocalizedString("purchaseDeniedText", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-semibold", size: 19)!]), forKey: "attributedTitle")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-regular", size: 17)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        // 'Ok'
        let okAction = UIAlertAction(title:  NSLocalizedString("ok", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            
        }
        
        // Add Actions
        alert.addAction(okAction)
        
        // Present Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // Loading
    func presentErrorAlert() {
        //
        // No connection nmessage
        let title = NSLocalizedString("subscriptionWarning", comment: "")
        let message = NSLocalizedString("subscriptionWarningMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-semibold", size: 19)!]), forKey: "attributedTitle")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-regular", size: 17)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        
        // Reset app action
        let okAction = UIAlertAction(title:  NSLocalizedString("userCheckedConnection", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            //
            if InAppManager.shared.products == [] {
                self.addLoadingView()
                InAppManager.shared.loadProducts()
            }
        }
        // Add Actions
        alert.addAction(okAction)
        
        // Present Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func failedToRestore() {
        // Add alert saying failed to restore
        loadingView.removeFromSuperview()
        self.presentFailedToRestoreAlert()
    }
    
    func presentFailedToRestoreAlert() {
        // Alert View indicating meaning of resetting the app
        let title = NSLocalizedString("restoreWarning", comment: "")
        let message = NSLocalizedString(InAppManager.shared.restoreFailedError, comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-semibold", size: 19)!]), forKey: "attributedTitle")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-regular", size: 17)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        // Reset app action
        let okAction = UIAlertAction(title:  NSLocalizedString("ok", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        // Add Actions
        alert.addAction(okAction)
        
        // Present Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // Timed out
    func timedOut() {
        loadingView.removeFromSuperview()
        self.presentErrorAlert()
    }
    
    // -------------------------------------------------------------
    // MARK: Loading
    // Loading
    func addLoadingView() {
        // Setup Alert
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.72)
        loadingView.frame = UIScreen.main.bounds
        
        // Setup indicator
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.center = loadingView.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.whiteLarge
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
    
    @objc func dismissLoadingWhatever() {
        loadingView.removeFromSuperview()
    }
}
