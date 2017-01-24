//
//  User.swift
//  CodingTestForMeltWater
//
//  Created by Jeswanth Bonthu on 1/21/17.
//  Copyright © 2017 Jeswanth Bonthu. All rights reserved.
//
import Alamofire
import ObjectMapper

class User:Mappable {
   
    var username = String()
    var avatarImage = AvatarImage()
    var avatharImg = UIImage()
    var userDescription = UserDiscriprion()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        username    <- map["username"]
        avatarImage <- map["avatar_image"]
        userDescription <- map["description"]
    }
}

class AvatarImage:Mappable
{
    var url = String()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        url    <- map["url"]
    }

}
class UserDiscriprion:Mappable
{
    var descriptionText = String()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        descriptionText    <- map["text"]
    }
    
}
