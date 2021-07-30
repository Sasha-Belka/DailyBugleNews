//
//  FavoriteViewPresenter.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 21.07.2021.
//

import UIKit

protocol FavoriteNewsPresenter {
    func pushDetailNews(view: UIViewController, favorite: FavoriteNews,news: Result, newsType: Int)
}

final class FavoriteNewsImpl: FavoriteNewsPresenter {
    
    let navigator: NewsNavigatorImpl

    init(navigator: NewsNavigatorImpl) {
        self.navigator = navigator
    }
    
    func pushDetailNews(view: UIViewController, favorite: FavoriteNews, news: Result, newsType: Int) {
        navigator.pushDetailNews(from: view, news: news, favorite: favorite, newsType: newsType)
    }
    
    
}
