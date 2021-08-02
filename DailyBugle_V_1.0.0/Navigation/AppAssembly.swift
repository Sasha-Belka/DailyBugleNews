//
//  AppAssembly.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 20.07.2021.
//

import UIKit

class AppAssembly: NSObject {
    
    func detailNewsController(navigator: NewsNavigatorImpl, news: Result, favorite: FavoriteNews, newsType: String) -> UIViewController {
        let viewController = DetailNewsViewController(news: news, favorite: favorite, newsType: newsType)
        return viewController
    }
}
