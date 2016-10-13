//
//  APICaller.swift
//  CaraotaDigital
//
//  Created by Jacobo Koenig on 10/10/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APICaller {
    
    func getAllNews(url: String, callback: @escaping (JSON, Bool?) ->()) {
        let newsURL = "http://caraotadigital.org/pruebas/wp-json/wp/v2/posts"
        //var parameters = ["part":"snippet, contentDetails", "playlistId":pID, "maxResults":"50", "key":apiKey]
        
        Alamofire.request(newsURL).responseJSON { response in
            switch response.result {
            case .success:
                callback(JSON(response.result.value), nil)
                
            case .failure:
                let error = response.result.isFailure
                callback(nil, error)
            }
        }
    }
}
