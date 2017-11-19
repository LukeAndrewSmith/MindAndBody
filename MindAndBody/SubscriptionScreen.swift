//
//  SubscriptionScreen.swift
//  MindAndBody
//
//  Created by Luke Smith on 18.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class SubscriptionScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //
    // Outlets
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var topSeparator: UIView!
    @IBOutlet weak var infoTable: UITableView!
    
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
        // Subtitle
        subtitleLabel.text = NSLocalizedString("initialInfoSubtitle", comment: "")
        //
        // Info Table
        infoTable.tableFooterView = UIView()
        infoTable.delegate = self
        infoTable.dataSource = self
        infoTable.separatorStyle = .none
        infoTable.isScrollEnabled = false
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
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return infoSections.count
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(infoSections[section], comment: "")
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
        header.textLabel?.textColor = Colours.colour1
        //
        header.backgroundColor = .clear
        header.backgroundView = UIView()
        //
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //
        if section == 1 {
            return 37 / 2
        } else {
            return 0
        }
    }
    
    
    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return 1
//        return infoBulletPoints[section].count
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Initial
        if indexPath.section == 0 {
            // Overview
//            return (tableView.bounds.height - 47) / 5
            return tableView.bounds.height
            
            // Overview cell
        } else if indexPath.section == 1 {
            let font = UIFont(name: "SFUIDisplay-thin", size: 21)
            let height =
                NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: "").height(withConstrainedWidth: infoTable.bounds.width - 32, font: font!)
            
            return height
        }
        return 0
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionCell") as! SubscriptionCell
            cell.backgroundColor = .clear
            cell.backgroundView = UIView()
            cell.selectionStyle = .none
            return cell
        } else {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.text = NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: "")
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cell.textLabel?.textColor = Colours.colour1
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        //
        // More info. cell
        if indexPath.section == 0 && indexPath.row == 4 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 15)
            cell.textLabel?.textAlignment = .right
            //
            // Bullet points
            //             Long text cell (more information text) has nothing done to it (hence if section != 2)
        }
        //        else if indexPath.section != 2 {
        //            //
        //            // Keep indentation constant
        //            let paragraphStyle: NSMutableParagraphStyle
        //            paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        //            paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: [:])]
        //            paragraphStyle.defaultTabInterval = 15
        //            paragraphStyle.firstLineHeadIndent = 0
        //            paragraphStyle.headIndent = 15
        //            // Font
        //            let bulletPointFont = UIFont(name: "SFUIDisplay-thin", size: 21)
        //            //
        //            let attributedString = NSMutableAttributedString(string: NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: ""))
        //            attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
        //            attributedString.addAttributes([NSAttributedStringKey.font: bulletPointFont!], range: NSMakeRange(0, attributedString.length))
        //            cell.textLabel?.attributedText = attributedString
        //            //
        //            // Indent if not overview (if features cells)
        //            if indexPath.section > 0 {
        //                cell.separatorInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        //            }
        //        }
        return cell
        }
        return UITableViewCell()
    }
    
    //
    // Did select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 4 {
            let indexPath = NSIndexPath(row: 0, section: 1)
            infoTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
            infoTable.isScrollEnabled = true
        }
    }
    //
    //    // Mask cells under clear header
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let visibleIndex = infoTable.indexPathsForVisibleRows
    //        if visibleIndex!.first?.section == 1 {
    //            for cell in infoTable.visibleCells {
    //                let hiddenFrameHeight = scrollView.contentOffset.y + 37 - cell.frame.origin.y
    //                if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
    //                    maskCell(cell: cell, margin: Float(hiddenFrameHeight))
    //                }
    //            }
    //        }
    //    }
    //    func maskCell(cell: UITableViewCell, margin: Float) {
    //        cell.layer.mask = visibilityMaskForCell(cell: cell, location: (margin / Float(cell.frame.size.height) ))
    //        cell.layer.masksToBounds = true
    //    }
    //    func visibilityMaskForCell(cell: UITableViewCell, location: Float) -> CAGradientLayer {
    //        let mask = CAGradientLayer()
    //        mask.frame = cell.bounds
    //        mask.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
    //        mask.locations = [NSNumber(value: location), NSNumber(value: location)]
    //        return mask;
    //    }
    //
    //
    // Ensure didCreateNewSchedule == false
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "openInitialCreateScheduleSegueMenu" {
            ScheduleVariables.shared.didCreateNewSchedule = false
        }
    }
    
    
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
