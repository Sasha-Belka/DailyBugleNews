//
//  AppAssembly.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 20.07.2021.
//

import UIKit

class AppAssembly: NSObject {
    
    func detailNewsController(navigator: NewsNavigatorImpl, news: [Result]?, index: Int) -> UIViewController {
        let presenter = DetailNewsPresenterImpl(navigator: navigator)
        let viewController = DetailNewsViewController(news: news, index: index, presenter: presenter)
        return viewController
    }
    func localNewsController(navigator: NewsNavigatorImpl, favorite: FavoriteNews) -> UIViewController{
        let presenter = LocalNewsPresenterImpl(navigator: navigator)
        let viewController = LocalViewController(favorite: favorite, presenter: presenter)
        return viewController
    }
}
