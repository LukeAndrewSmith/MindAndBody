//
//  InfoPageController.swift
//  MindAndBody
//
//  Created by Luke Smith on 20.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class InfoPageControl {
    static var shared = InfoPageControl()
    private init() {}
    
    let pageControl = UIPageControl()

    func setupPageControl(x: CGFloat, y: CGFloat) {
        //
        pageControl.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 24)
        pageControl.center = CGPoint(x: x, y: y)
        //
    }
}

class InfoPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let page1: UIViewController! = (storyboard?.instantiateViewController(withIdentifier: "InfoTable1"))! as! InfoTable1
        let page2: UIViewController! = (storyboard?.instantiateViewController(withIdentifier: "InfoTable2"))! as! InfoTable2
        let page3: UIViewController! = (storyboard?.instantiateViewController(withIdentifier: "InfoTable3"))! as! InfoTable3
        let page4: UIViewController! = (storyboard?.instantiateViewController(withIdentifier: "InfoTable4"))! as! InfoTable4
        let page5: UIViewController! = (storyboard?.instantiateViewController(withIdentifier: "InfoTable5"))! as! InfoTable5
        let page6: UIViewController! = (storyboard?.instantiateViewController(withIdentifier: "InfoTable6"))! as! InfoTable6

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        pages.append(page5)
        pages.append(page6)
        
        setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        
        //
        InfoPageControl.shared.pageControl.numberOfPages = pages.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        if currentIndex == pages.count - 1 {
            return nil
        } else {
            let nextIndex = currentIndex + 1
            return pages[nextIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        if currentIndex == 0 {
            return nil
        } else {
            let previousIndex = currentIndex - 1
            return pages[previousIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        InfoPageControl.shared.pageControl.currentPage = pages.index(of: pageContentViewController)!
    }

}
