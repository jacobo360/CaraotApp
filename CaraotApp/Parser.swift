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
        
        var newString = ""
        
        for _ in 0...5 {
            newString = innerParse(withString: withString)
        }
    
        return newString
        
    }
    
    func innerParse(withString: String) -> String {
        
        var newString = ""
        
        if withString.containsSub("<div") && withString.containsSub("</div>") {
            newString = withString[0..<withString.indexOf("<div")!]
                + withString.substring(withString.indexOf("</div>")! + 6, length: withString.characters.count - (withString.indexOf("</div>")! + 6))
            newString = parseStyle(withString: newString)
            
            return newString
        } else {
            return withString
        }
        
    }
    
    func parseStyle(withString: String) -> String {
        
        var newString = ""
        
        if withString.containsSub("<style") && withString.containsSub("</style>") {
            print(withString.characters.count)
            newString = withString[0..<withString.indexOf("<style")!]
                + withString.substring(withString.indexOf("</style>")! + 8, length: withString.characters.count - (withString.indexOf("</style>")! + 8))
        } else {
            return withString
        }
        
        if newString.containsSub("<style") && withString.containsSub("</style>") {
            newString = parseStyle(withString: newString)
        }
        
        return newString
        
    }
    
}
