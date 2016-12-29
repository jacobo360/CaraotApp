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
import Spring

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
    @IBOutlet weak var caraotaAnim: SpringImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = nTitle
        authorLbl.text = nAuthor
        contentLbl.htmlText = nContent
        contentLbl.firstLineIndent = 20
        categoryLbl.text = nCategory
        imgView.kf.setImage(with: URL(string: nImage!), placeholder: UIImage(named: "salto_angel"))
        categoryLbl.layer.cornerRadius = 7
        categoryLbl.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if (self.parent as! PageViewController).loading {
            
            caraotaAnim.isHidden = false
            
        } else {
            
            caraotaAnim.isHidden = true
            
        }
        
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
