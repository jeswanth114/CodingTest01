//
//  CachedDataManager.swift
//  CodingTestForMeltWater
//
//  Created by Jeswanth Bonthu on 1/23/17.
//  Copyright © 2017 Jeswanth Bonthu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CachedDataManager: NSObject {
    

    
   func cacheFetchedPosts(_ posts: [Post], completion: @escaping (_ posts: [PostObject]? , _ error : Error?) -> Void) {
    
    let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext

    
    var managedArray = [PostObject]()
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"PostObject")
    
    do {
    let fetchedResults = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
    
    if let managedObjects = fetchedResults as [NSManagedObject]! {
    for managedObject in managedObjects {
    managedContext.delete(managedObject)
    }
    
    try managedContext.save()
    }
    } catch {
    print("Error: \(error)")
    }
        
    for post in posts {
        let managedPost = PostObject(postData: post, inManagedObjectContext: managedContext)
        managedArray.append(managedPost)
    }
    
    do {
    try managedContext.save()
    completion(managedArray,nil)
    } catch {
    print("Error: \(error)")
    completion(nil,error)
    }
    }
    
    func testData(manageContext : NSManagedObjectContext)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"PostObject")
        
        do {
            let fetchedResults = try manageContext.fetch(fetchRequest) as? [PostObject]
            
            print(fetchedResults as Any)
        } catch {
            print("Error: \(error)")
        }
    }
}
