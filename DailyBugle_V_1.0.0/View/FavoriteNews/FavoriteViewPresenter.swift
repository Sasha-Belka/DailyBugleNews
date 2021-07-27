//
//  FavoriteViewPresenter.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 21.07.2021.
//

import UIKit

protocol FavoriteNewsPresenter {
    func pushLocalNews(view: UIViewController, favorite: FavoriteNews)
}

final class FavoriteNewsImpl: FavoriteNewsPresenter {
    
    let navigator: NewsNavigatorImpl

    init(navigator: NewsNavigatorImpl) {
        self.navigator = navigator
    }
    
    func pushLocalNews(view: UIViewController, favorite: FavoriteNews) {
        navigator.pushLocalNews(viewController: view, favorite: favorite)
    }

    
    
}
