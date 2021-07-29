//
//  FavoriteData.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 21.07.2021.
//

import UIKit
import CoreData

protocol FavoriteDataProtocol {
    func saveFavoriteNews(headTitle: String?, source: String?, section: String?, update: String?, imageUrl: String?)
}

class FavoriteData: FavoriteDataProtocol {
    
    var favorites: [FavoriteNews]?
    let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveFavoriteNews(headTitle: String?, source: String?, section: String?, update: String?, imageUrl: String?) {
        let newFavorite = FavoriteNews(context: self.context)
        newFavorite.headTitle = headTitle
        newFavorite.source = source
        newFavorite.id = section
        newFavorite.id = update
        newFavorite.imageUrl = imageUrl
        do {
            try self.context.save()
        }
        catch {
            print("Error")
        }
    }
    
    func fetchFavorite(tableView: UITableView) {
        do {
            let request = FavoriteNews.fetchRequest()  as NSFetchRequest<FavoriteNews>
            self.favorites = try context.fetch(request)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
        catch {
            print("Error")
        }
    }
    func removeCell(cellToRemove: FavoriteNews) {
        self.context.delete(cellToRemove)
       
        do {
            try self.context.save()
        }
        catch {
            print("Error")
        }
    }
    func removeButton(data: FavoriteNews) {
        self.context.delete(data)
       
        do {
            try self.context.save()
        }
        catch {
            print("Error")
        }
    }

}
