//
//  PostObject+Properties.swift
//  CodingTestForMeltWater
//
//  Created by Jeswanth Bonthu on 1/23/17.
//  Copyright © 2017 Jeswanth Bonthu. All rights reserved.
//

import Foundation
import CoreData


extension PostObject {
    @NSManaged var userName: String?
    @NSManaged var userDescription: String?
    @NSManaged var avatarImageURL: String?
    @NSManaged var avatarImage: NSObject?
    @NSManaged var date: Date?
}
