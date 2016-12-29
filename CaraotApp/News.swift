//
//  NewsModel.swift
//  CaraotaDigital
//
//  Created by Juan Calcagno on 26/9/16.
//  Copyright © 2016 JuanCalcagno. All rights reserved.
//

import Foundation

class News: NSObject, NSCoding {
    
    var postId:Int?
    var postURL:String?
    var postDate:String?
    var nTitle:String?
    var imageUrl:String?
    var content:String?
    var authorLink:String?
    var categoryName:String?
    
    required init(title:String,imageUrl:String,content:String,postId:Int,postDate:String,postURL:String,authorLink:String,categoryName:String){
        
        self.postId = postId
        self.postDate = postDate
        self.nTitle = title
        self.imageUrl = imageUrl
        self.content = content
        self.postURL = postURL
        self.authorLink = authorLink
        self.categoryName = categoryName
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        
        let postId     = aDecoder.decodeInteger(forKey: "postId")
        let postUrl    = aDecoder.decodeObject(forKey: "postUrl") as! String
        let postDate   = aDecoder.decodeObject(forKey: "postDate") as! String
        let title      = aDecoder.decodeObject(forKey: "title") as! String
        let imageUrl   = aDecoder.decodeObject(forKey: "imageUrl") as! String
        let content    = aDecoder.decodeObject(forKey: "content") as! String
        let authorLink = aDecoder.decodeObject(forKey: "authorLink") as! String
        let categoryName = aDecoder.decodeObject(forKey: "categoryName") as! String
        
        self.init(title:title,imageUrl: imageUrl,content: content,postId: postId,postDate: postDate,
                  postURL: postUrl,
                  authorLink: authorLink,
                  categoryName: categoryName)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(postId!, forKey: "postId")
        aCoder.encode(postURL!, forKey: "postUrl")
        aCoder.encode(postDate!, forKey: "postDate")
        aCoder.encode(nTitle!, forKey: "title")
        aCoder.encode(imageUrl!, forKey: "imageUrl")
        aCoder.encode(content!, forKey: "content")
        aCoder.encode(authorLink, forKey: "authorLink")
        aCoder.encode(categoryName, forKey: "categoryName")
        
        
    }
    
}
