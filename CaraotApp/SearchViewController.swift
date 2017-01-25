//
//  SearchViewController.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 10/13/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import UIKit
import SwiftyJSON
import MDHTMLLabel
import Spring

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    var results: [News] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var loader: SpringImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        searchBar.delegate = self
        tblView.delegate = self
        tblView.dataSource = self
        
        //Design
        searchBar.barTintColor = UIColor(red:0.24, green:0.24, blue:0.24, alpha:1.0)
        let textField = searchBar.value(forKey: "searchField") as? UITextField
        let glassIconView = textField?.leftView as? UIImageView
       
        glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        glassIconView?.tintColor = UIColor.white
        
        textField?.textColor = UIColor.white
        textField?.font = UIFont.systemFont(ofSize: 20)
        textField?.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.title = "Buscador de Noticias"
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        loader.isHidden = false
        
        let text = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = "http://caraotadigital.net/wp-json/wp/v2/posts?_embed&search=\(text!)"
        
        APICaller().getAllNews(url: url) { response in
            
            self.loader.isHidden = true
            
            if response.0 != JSON.null && response.0.count != 0 {
                self.results.removeAll(keepingCapacity: false)
                for i in 0..<response.0.count {
                    let post = News(
                        title: response.0[i]["title"]["rendered"].stringValue.decodeHTML(),
                        imageUrl:response.0[i]["_embedded"]["wp:featuredmedia"][0]["source_url"].stringValue,
                        content:response.0[i]["excerpt"]["rendered"].stringValue.decodeHTML(),
                        postId:response.0[i]["id"].intValue,
                        postDate:response.0[i]["date"].stringValue,
                        postURL:response.0[i]["link"].stringValue,
                        authorLink:response.0[i]["_embedded"]["author"][0]["name"].stringValue,
                        categoryName:response.0[i]["_embedded"]["wp:term"][0][0]["name"].stringValue)
                    self.results.append(post)
                }
                self.tblView.reloadData()
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "proto")
        let category = cell?.viewWithTag(2) as! MDHTMLLabel
        let nTitle = cell?.viewWithTag(1) as! UILabel
        
        category.layer.cornerRadius = 7
        category.clipsToBounds = true
        
        category.htmlText = results[indexPath.row].content!
        nTitle.text = results[indexPath.row].nTitle
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = URL(string: results[indexPath.row].postURL!)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }

    }

}
