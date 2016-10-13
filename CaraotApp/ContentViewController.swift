//
//  ContentViewController.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 10/11/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import UIKit
import Kingfisher
import MDHTMLLabel

class ContentViewController: UIViewController {

    var pageIndex: Int?
    var nTitle: String?
    var nAuthor: String?
    var nContent: String?
    var nCategory: String?
    var nImage: String?
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var contentLbl: MDHTMLLabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = nTitle
        authorLbl.text = nAuthor
        contentLbl.htmlText = nContent
        categoryLbl.text = nCategory
        imgView.kf.setImage(with: URL(string: nImage!), placeholder: UIImage(named: "salto_angel"))
        categoryLbl.layer.cornerRadius = 7
        categoryLbl.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
