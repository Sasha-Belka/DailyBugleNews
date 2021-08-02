//
//  RouterProtocol.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 19.07.2021.
//

import UIKit

protocol NewsNavigatorProtocol {
    func pushDetailNews(from: UIViewController, news: Result, favorite: FavoriteNews, newsType: String)
}

var appAssembly = AppAssembly()

class NewsNavigatorImpl: NewsNavigatorProtocol {
    
    func pushDetailNews(from viewController: UIViewController, news: Result, favorite: FavoriteNews, newsType: String) {
        let vc = appAssembly.detailNewsController(navigator: self, news: news, favorite: favorite, newsType: newsType)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

