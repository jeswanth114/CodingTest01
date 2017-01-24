//
//  PostObject.swift
//  CodingTestForMeltWater
//
//  Created by Jeswanth Bonthu on 1/23/17.
//  Copyright © 2017 Jeswanth Bonthu. All rights reserved.
//

import Foundation
import CoreData

@objc(PostObject)
class PostObject: NSManagedObject {    
    // Insert code here to add functionality to your managed object subclass
    
    convenience init(postData: Post, inManagedObjectContext context: NSManagedObjectContext) {
        
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "PostObject", in: context)!
        
        self.init(entity: entity, insertInto: context)
        
        self.userName = postData.user.username
        self.userDescription = postData.user.userDescription.descriptionText
        self.avatarImageURL  = postData.user.avatarImage.url
        
        let strTime = postData.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
        self.date  = formatter.date(from: strTime!)
        self.avatarImage = postData.user.avatharImg
    }
}
