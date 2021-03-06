//
//  PageViewController.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 10/11/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import UIKit
import SwiftyJSON

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController?
    var newsArray: [News] = []
    var titles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        setViewControllers([viewControllerAt(index: 0)],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        
        APICaller().getAllNews(url: "http://caraotadigital.org/pruebas/wp-json/wp/v2/posts?_embed") { response in
            if response.0 != JSON.null && response.0.count != 0 {
                for i in 0..<response.0.count {
                    let post = News(
                        title: response.0[i]["title"]["rendered"].stringValue,
                        imageUrl:response.0[i]["_embedded"]["wp:featuredmedia"][0]["source_url"].stringValue,
                        content:response.0[i]["content"]["rendered"].stringValue,
                        postId:response.0[i]["id"].intValue,
                        postDate:response.0[i]["date"].stringValue,
                        postURL:response.0[i]["link"].stringValue,
                        authorLink:response.0[i]["_embedded"]["author"][0]["name"].stringValue,
                        categoryName:response.0[i]["_embedded"]["wp:term"][0][0]["name"].stringValue)
                    self.newsArray.append(post)
                }
                
                self.setViewControllers([self.viewControllerAt(index: 0)],
                                   direction: .forward,
                                   animated: true,
                                   completion: nil)
            }
        }

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
        
        let vc = viewController as? ContentViewController
        var index = vc?.pageIndex
        
        if index == nil || index == NSNotFound {
            return nil
        }
        
        index! += 1
        
        if index == self.newsArray.count {
            return nil
        }
        
        return viewControllerAt(index: index!)
        
    }
    
    func viewControllerAt(index: Int) -> UIViewController {
        
        if newsArray.count == 0 || index >= newsArray.count {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let lVC = storyboard.instantiateViewController(withIdentifier: "LoadingView")
            return lVC
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cVC: ContentViewController = storyboard.instantiateViewController(withIdentifier: "ContentVC") as! ContentViewController
        
        cVC.pageIndex = index
        cVC.nTitle = newsArray[index].nTitle
        cVC.nAuthor = newsArray[index].authorLink
        cVC.nCategory = "  " + newsArray[index].categoryName! + "  "
        cVC.nContent = newsArray[index].content
        cVC.nImage = newsArray[index].imageUrl
        
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
