//
//  PageViewController.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 10/11/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController?
    var newsArray: [String] = ["Example", "Example2", "Example3"]
    var titles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        setViewControllers([viewControllerAt(index: 0)],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        index! -= 1
        return viewControllerAt(index: index!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex
        if index == NSNotFound {
            return nil
        }
        
        index! += 1
        
        if index == self.newsArray.count {
            return nil
        }
        
        return viewControllerAt(index: index!)
        
    }
    
    func viewControllerAt(index: Int) -> ContentViewController {
        
        if newsArray.count == 0 || index >= newsArray.count {
            print("returning nil")
            return ContentViewController()
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cVC: ContentViewController = storyboard.instantiateViewController(withIdentifier: "ContentVC") as! ContentViewController
        
        cVC.pageIndex = index
        cVC.nTitle = "Title \(index)"
        
        if index == 1 {
            cVC.color = UIColor.green
        } else if index == 2 {
            cVC.color = UIColor.red
        } else {
            cVC.color = UIColor.yellow
        }
        
        cVC.title = "Title \(index)"
        cVC.nAuthor = "Author"
        cVC.nCategory = "  Deportes \(index)  "
        cVC.nContent = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        print("returning some")
        return cVC
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
