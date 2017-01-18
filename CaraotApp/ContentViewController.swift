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
    var isFavorite: Bool = false
    var news: News?
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var contentLbl: MDHTMLLabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var caraotaAnim: SpringImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = nTitle?.decodeHTML()
        authorLbl.text = nAuthor
        
        var str: NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        do {
            str = try NSMutableAttributedString(HTMLString: nContent!.decodeHTML(), font: UIFont(name: "Helvetica", size: 16.0)!)!
        } catch {
            print("could not parse")
        }
        
        contentLbl.attributedText = str
        contentLbl.firstLineIndent = 20
        
        categoryLbl.text = nCategory
        imgView.kf.setImage(with: URL(string: nImage!), placeholder: UIImage(named: "caraota-background"))
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if (self.parent as! PageViewController).loading {
            
            caraotaAnim.isHidden = false
            
        } else {
            
            caraotaAnim.isHidden = true
            
        }
        
    }
    
}

extension NSAttributedString {
    
    public convenience init?(HTMLString html: String, font: UIFont? = nil) throws {
        
        let options: [String: Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSNumber(value: String.Encoding.utf8.rawValue)
        ]
        
        guard let data = html.data(using: .utf8, allowLossyConversion: true) else {
            throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
        }
        
        
        if let font = font {
            guard let attr = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else {
                throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
            }
            var attrs = attr.attributes(at: 0, effectiveRange: nil)
            attrs[NSFontAttributeName] = font
            attr.setAttributes(attrs, range: NSRange(location: 0, length: attr.length))
            self.init(attributedString: attr)
        } else {
            try? self.init(data: data, options: options, documentAttributes: nil)
        }
        
    }
    
}
