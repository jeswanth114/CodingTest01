//
//  Post.swift
//  CodingTestForMeltWater
//
//  Created by Jeswanth Bonthu on 1/20/17.
//  Copyright © 2017 Jeswanth Bonthu. All rights reserved.
//

import Alamofire
import ObjectMapper



class MainResponse: Mappable {
    var postsData: [Post]?

    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        postsData <- map["data"]
        
    }
}

class Post:Mappable {
    var user = User()
    var date : String!
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        user    <- map["user"]
        date <- map["created_at"]
    }
}

