//
//  Parser.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 12/29/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import Foundation
import SwiftString

class Parser {
    
    func parseIMG(withString: String) -> String {
        
        var newString = withString
        
        for _ in 0..<5 {
            newString = innerParse(withString: newString)
        }
        
        
        newString = parseRecom(withString: newString)
        newString = parseStyle(withString: newString)
    
        return newString
        
    }
    
    func innerParse(withString: String) -> String {
        
        var newString = ""
        
        if withString.containsSub("<div") && withString.containsSub("</div>") {
            newString = withString[0..<withString.indexOf("<div")!].trimmed()
                + withString.substring(withString.indexOf("</div>")! + 6, length: withString.characters.count - (withString.indexOf("</div>")! + 6)).trimmed()
            
            return newString
        } else {
            return withString
        }
        
    }
    
    func parseStyle(withString: String) -> String {
        
        var newString = ""
        
        if withString.containsSub("<style") && withString.containsSub("</style>") {
            newString = withString[0..<withString.indexOf("<style")!].trimmed()
                + withString.substring(withString.indexOf("</style>")! + 8, length: withString.characters.count - (withString.indexOf("</style>")! + 8)).trimmed()
        } else {
            return withString
        }
        
        if newString.containsSub("<style") && withString.containsSub("</style>") {
            newString = parseStyle(withString: newString)
        }
        
        return newString
        
    }
    
    func parseRecom(withString: String) -> String {
        
        var newString = ""
        
        if withString.containsSub("Le puede interesar:") {
            newString = withString[0..<(withString.indexOf("Le puede interesar:")! - 11)]
        } else {
            return withString
        }
    
        return newString
    }
}
