//
//  Favorite+CoreDataPropertiess.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 04.08.2021.
//

import Foundation
import CoreData


extension FavoriteNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteNews> {
        return NSFetchRequest<FavoriteNews>(entityName: "FavoriteNews")
    }

    @NSManaged public var headTitle: String?
    @NSManaged public var id: Int64
    @NSManaged public var imageUrl: String?
    @NSManaged public var section: String?
    @NSManaged public var source: String?
    @NSManaged public var adxKeywords: String?

}
