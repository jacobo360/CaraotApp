//
//  PageViewController.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 10/11/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import UIKit
import SwiftyJSON
import GoogleMobileAds

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, GADInterstitialDelegate {

    var pageViewController: UIPageViewController?
    var newsArray: [News] = []
    var titles: [String] = []
    var page = 1
    var redo = false
    var loading = false
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.array(forKey: "selectedCategories") == nil {
            redo = true
            performSegue(withIdentifier: "to_categories", sender: self)
        } else {
        
            dataSource = self
            
            setViewControllers([viewControllerAt(index: 0)],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            
            getNews(andReload: true)
            
        }
    
        //Design
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if redo {
            setViewControllers([viewControllerAt(index: 0)],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            
            getNews(andReload: true)
        }
    }
    
    func getNews(andReload: Bool) {
        
        loading = true
        
        //Append fav categories if existent
        var categories = ""
        if let selected = defaults.array(forKey: "selectedCategories") as? [Int] {
            if selected.count != 0 {
                categories = "&categories="
                for i in 0..<selected.count {
                    if i != selected.count - 1 {
                        categories = categories + "\(selected[i]),"
                    } else {
                        categories = categories + "\(selected[i])"
                    }
                }
            }
        }
        
        print("http://caraotadigital.net/wp-json/wp/v2/posts?_embed&per_page=10&page=\(page)\(categories)")
        
        APICaller().getAllNews(url: "http://caraotadigital.net/wp-json/wp/v2/posts?_embed&per_page=10&page=\(page)\(categories)") { response in
            if response.0 != JSON.null && response.0.count != 0 {
                
                //Controls loading icon in ContentVC
                self.loading = false
                
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
                    
                    //APPEND IF NOT REPEATED
                    //Get arrayof ids from newsArray
                    var ids: [Int] = []
                    for news in self.newsArray {
                        ids.append(news.postId!)
                    }
                    //Check if newsArray contains id
                    if !ids.contains(post.postId!) {
                        self.newsArray.append(post)
                    }
                
                }
            
                self.page += 1
                
                if andReload {
                    print("SETTING NEW")
                    self.setViewControllers([self.viewControllerAt(index: 0)],
                                            direction: .forward,
                                            animated: true,
                                            completion: nil)
                } else {
                    let currentIndex = (self.childViewControllers[0] as! ContentViewController).pageIndex! + 1
                    print("CURRENT INDEX IS \(currentIndex)")
//                    print("CURRENT VCs ARE \(self.childViewControllers)")
                    self.setViewControllers([self.viewControllerAt(index: currentIndex)],
                                            direction: .forward,
                                            animated: false,
                                            completion: nil)
                }
                
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
        
        if index == self.newsArray.count - 2 {
            getNews(andReload: false)
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
        
        (parent as! ViewController).news = newsArray[index]
        (parent as! ViewController).setRightNavItems()
        cVC.pageIndex = index
        cVC.nTitle = newsArray[index].nTitle
        cVC.nAuthor = newsArray[index].authorLink
        cVC.nCategory = "  " + newsArray[index].categoryName! + "  "
        cVC.nContent = newsArray[index].content
        cVC.nImage = newsArray[index].imageUrl
        
        return cVC
    }

    func createAndLoadInterstitial() -> GADInterstitial {
        let interst = GADInterstitial(adUnitID: "ca-app-pub-8117643233045904/4768307876")
        interst.delegate = self
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
//        request.testDevices = [ kGADSimulatorID ]
        let request = GADRequest()
        request.setLocationWithLatitude(10.500000, longitude: -66.916664, accuracy: 1_000_000)
//        request.keywords = ["Noticias", "Venezuela", "Inversion", "Caracas"]
        interst.load(request)
        
        return interst
    }
    
    func showInterstitial() {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
}
