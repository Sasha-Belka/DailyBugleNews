//
//  RouterProtocol.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 19.07.2021.
//

import UIKit

protocol NewsNavigatorProtocol {
    func pushDetailNews(from: UIViewController, news: [Result]?, index: Int)
    func pushLocalNews(viewController: UIViewController, favorite: FavoriteNews)
}

var appAssembly = AppAssembly()

class NewsNavigatorImpl: NewsNavigatorProtocol {
    func pushLocalNews(viewController: UIViewController, favorite: FavoriteNews) {
        let vc = appAssembly.localNewsController(navigator: self, favorite: favorite)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func pushDetailNews(from viewController: UIViewController, news: [Result]?, index: Int) {
        let vc = appAssembly.detailNewsController(navigator: self, news: news, index: index)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

