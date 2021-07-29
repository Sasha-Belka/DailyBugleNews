//
//  FavoriteNews+CoreDataProperties.swift
//  
//
//  Created by Oleksandr Kostogryz on 21.07.2021.
//
//

import Foundation
import CoreData


extension FavoriteNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteNews> {
        return NSFetchRequest<FavoriteNews>(entityName: "FavoriteNews")
    }

    @NSManaged public var headTitle: String?
    @NSManaged public var source: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var abstract: String?
    @NSManaged public var id: String?
}
