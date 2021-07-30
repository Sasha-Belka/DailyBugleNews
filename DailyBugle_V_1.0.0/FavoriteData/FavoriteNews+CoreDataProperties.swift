//
//  FavoriteNews+CoreDataProperties.swift
//  
//
//  Created by Oleksandr Kostogryz on 30.07.2021.
//
//

import Foundation
import CoreData


extension FavoriteNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteNews> {
        return NSFetchRequest<FavoriteNews>(entityName: "FavoriteNews")
    }

    @NSManaged public var headTitle: String?
    @NSManaged public var id: Double
    @NSManaged public var imageUrl: String?
    @NSManaged public var section: String?
    @NSManaged public var source: String?

}
