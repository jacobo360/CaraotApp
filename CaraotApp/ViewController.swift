//
//  ViewController.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 10/11/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import UIKit
import RESideMenu

class ViewController: RESideMenu, RESideMenuDelegate {

    var isFavorite = false
    var news: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Design
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu_white"), style: .plain, target: self, action: #selector(ViewController.menuTapped))
        
        if news != nil {
            setRightNavItems()
        }
        
    }

    func segue(tag: Int) {
        
        switch tag {
        case 1:
            performSegue(withIdentifier: "to_perfil", sender: self)
            break
        case 2:
            performSegue(withIdentifier: "to_buscador", sender: self)
            break
        case 3:
            performSegue(withIdentifier: "to_reportero", sender: self)
            break
        default:
            break
        }
        
    }
    
    func menuTapped() {
        
        self.presentLeftMenuViewController()
        
    }
    
    func setRightNavItems() {
        
        //Set Favorite
        if let data = defaults.object(forKey: "favoriteArticles") as? Data {
            
            let favs = NSKeyedUnarchiver.unarchiveObject(with: data) as! [News]
            
            isFavorite = favs.contains { $0.nTitle == news?.nTitle }
        }
        
        var favBtn = UIBarButtonItem()
        
        if !isFavorite {
            favBtn = UIBarButtonItem(image: UIImage(named: "ic_favorite_border_white"), style: .plain, target: self, action: #selector(self.favTapped))
        } else {
            favBtn = UIBarButtonItem(image: UIImage(named: "ic_favorite_white"), style: .plain, target: self, action: #selector(self.favTapped))
        }
        
        //Share Button
        let shareBtn = UIBarButtonItem(image: UIImage(named: "ic_share_white"), style: .plain, target: self, action: #selector(self.shareTapped))
        
        self.navigationItem.setRightBarButtonItems([favBtn, shareBtn], animated: true)
        
    }
    
    func shareTapped() {
        // text to share
        let text = "This is some text that I want to share."
        
        // set up activity view controller
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func favTapped() {
        
        if !isFavorite {
            
            if let data = defaults.object(forKey: "favoriteArticles") as? Data {
                
                var favs = NSKeyedUnarchiver.unarchiveObject(with: data) as! [News]
                favs.append(news!)
                defaults.set(NSKeyedArchiver.archivedData(withRootObject: favs), forKey: "favoriteArticles")
                
            } else {
                
                let data = NSKeyedArchiver.archivedData(withRootObject: [news!])
                defaults.set(data, forKey: "favoriteArticles")
                
            }
            
        } else {
            
            if let data = defaults.object(forKey: "favoriteArticles") as? Data {
                
                var favs = NSKeyedUnarchiver.unarchiveObject(with: data) as! [News]
                
                for i in 0..<favs.count {
                    if favs[i].nTitle == news?.nTitle {
                        favs.remove(at: i)
                    }
                }
                
                defaults.set(NSKeyedArchiver.archivedData(withRootObject: favs), forKey: "favoriteArticles")
                
            } else {
                print("THIS ERROR SHOULD NOT COME UP")
            }
            
        }
        
        setRightNavItems()
        
    }

    func sideMenu(_ sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func sideMenu(_ sideMenu: RESideMenu!, didHideMenuViewController menuViewController: UIViewController!) {
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
}

