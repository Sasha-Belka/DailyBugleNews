//
//  AppAssembly.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 20.07.2021.
//

import UIKit

class AppAssembly: NSObject {
    
    func detailNewsController(navigator: NewsNavigatorImpl, news: Result, favorite: FavoriteNews, newsType: Int) -> UIViewController {
        let presenter = DetailNewsPresenterImpl(navigator: navigator)
        let viewController = DetailNewsViewController(news: news, presenter: presenter, favorite: favorite, newsType: newsType)
        return viewController
    }
}
