//
//  InfoPageController.swift
//  MindAndBody
//
//  Created by Luke Smith on 20.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class InfoPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let page1: UITableViewController! = (storyboard?.instantiateViewController(withIdentifier: "InfoTable1"))! as! InfoTable1
        let page2: UITableViewController! = (storyboard?.instantiateViewController(withIdentifier: "InfoTable2"))! as! InfoTable2
//        let page3: UITableViewController! = (storyboard?.instantiateViewController(withIdentifier: "InfoTable3"))! as! InfoTable3
//        let page4: UITableViewController! = (storyboard?.instantiateViewController(withIdentifier: "InfoTable4"))! as! InfoTable4

        pages.append(page1)
        pages.append(page2)
//        pages.append(page3)
//        pages.append(page4)
        
        setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
