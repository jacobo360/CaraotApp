//
//  CategoryChooserViewController.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 12/28/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import UIKit
import SwiftyJSON

class CategoryChooserViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var categories: [Int : String] = [:]
    
    @IBOutlet weak var collView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collView.delegate = self
        collView.dataSource = self
        
        getCategories()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Array(categories.keys).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let checkmark = cell.viewWithTag(2) as! UIImageView
        let lbl = cell.viewWithTag(1) as! UILabel
        lbl.text = categories[Array(categories.keys)[indexPath.item]]
        
        //If category has been selected
        if let selected = defaults.array(forKey: "selectedCategories") as? [Int] {
            
            if selected.contains(Array(categories.keys)[indexPath.item]) {

                cell.alpha = 1
                cell.backgroundColor = COLORS[indexPath.item % 4]
                checkmark.isHidden = false
                
            } else {
                cell.alpha = 0.5
                cell.backgroundColor = UIColor.lightGray
                checkmark.isHidden = true
            }
        } else {
            cell.alpha = 0.5
            cell.backgroundColor = UIColor.lightGray
            checkmark.isHidden = true
        }
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if var selected = defaults.array(forKey: "selectedCategories") as? [Int] {
        
            if selected.contains(Array(categories.keys)[indexPath.item]) {
                
                selected.remove(at: selected.index(of: Array(categories.keys)[indexPath.item])!)
                defaults.set(selected, forKey: "selectedCategories")
                
            } else {
                
                selected.append(Array(categories.keys)[indexPath.item])
                defaults.set(selected, forKey: "selectedCategories")
                
            }
            
        } else {
            
            defaults.set([Array(categories.keys)[indexPath.item]], forKey: "selectedCategories")
            
        }
        
        self.collView.reloadData()
        
    }
    
    func getCategories() {
        
        APICaller().getAllNews(url: "http://caraotadigital.net/wp-json/wp/v2/categories?per_page=50") { response in
            
            if response.0 != JSON.null && response.0.count != 0 {
                for i in 0..<response.0.count {
                    self.categories[response.0[i]["id"].intValue] = response.0[i]["name"].stringValue
                    defaults.set(response.0[i]["name"].stringValue, forKey: "cat" + response.0[i]["id"].stringValue)
                }
            }
            
        self.collView.reloadData()
            
        }
    }
    
    @IBAction func guardarBtn(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

let defaults = UserDefaults.standard
let LIGHT_GREEN = UIColor(red:0.31, green:0.67, blue:0.17, alpha:1.0)
let LIGHT_BLUE = UIColor(red:0.62, green:0.74, blue:0.95, alpha:1.0)
let DARK_GREEN = UIColor(red:0.09, green:0.24, blue:0.20, alpha:1.0)
let RED = UIColor(red:0.92, green:0.29, blue:0.31, alpha:1.0)
let COLORS = [LIGHT_GREEN, DARK_GREEN, LIGHT_BLUE, RED]
