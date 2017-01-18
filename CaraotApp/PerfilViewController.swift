//
//  PerfilViewController.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 12/30/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var catLbl: UILabel!
    @IBOutlet weak var favLbl: UILabel!
    @IBOutlet weak var catCollView: UICollectionView!
    @IBOutlet weak var favCollView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        catCollView.delegate = self
        catCollView.dataSource = self
        favCollView.delegate = self
        favCollView.dataSource = self
        
        //Design
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        if let categories = defaults.array(forKey: "selectedCategories") as? [Int] {
            catLbl.text = String(categories.count)
        }
        
        if let favorites = defaults.array(forKey: "favoriteArticles") as? [News] {
            favLbl.text = String(favorites.count)
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case catCollView:
            
            return (defaults.array(forKey: "selectedCategories")?.count)!
            
        case favCollView:
            
            if let favorites = defaults.array(forKey: "favoriteArticles") {
                return favorites.count
            } else {
                return 1
            }
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == favCollView {
            
            if collectionView.frame.height < 190 {
                return CGSize(width: collectionView.frame.width*12/19, height: collectionView.frame.height - 8)
            } else {
                return CGSize(width: 120, height: 190)
            }
            
        } else {
         
            return CGSize(width: 125, height: 25)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case catCollView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath)
            let label = cell.viewWithTag(1) as! UILabel
            
            label.backgroundColor = COLORS[indexPath.item % 4]
            
            if let categories = defaults.array(forKey: "selectedCategories") as? [Int] {
                label.text = defaults.object(forKey: "cat" + String(categories[indexPath.item])) as! String?
            }
            
            return cell
            
        case favCollView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath)
            let background = cell.viewWithTag(2) as! UIImageView
            let label = cell.viewWithTag(3) as! UILabel
            
            if let favorites = defaults.array(forKey: "favoriteArticles") as? [News] {
                
                do {
                    background.image? = try UIImage(data: Data(contentsOf: URL(string: favorites[indexPath.item].imageUrl!)!))!
                } catch {
                    print("NO IMAGE")
                }
                
                label.text = favorites[indexPath.item].nTitle
                
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
    }

}
