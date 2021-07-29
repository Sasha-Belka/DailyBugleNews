//
//  MostViewedPresenter.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 16.07.2021.
//

import UIKit

protocol NewsViewPresenterProtocol : class {
    func getNews<T>(completion: @escaping ([Result]?) -> Void, apiType: T)

    func pushDetailNews(view: UIViewController, news: Result)
}

final class NewsViewPresenter: NewsViewPresenterProtocol {
   
    let navigator: NewsNavigatorImpl

    init(navigator: NewsNavigatorImpl) {
        self.navigator = navigator
    }
    func getNews<T>(completion: @escaping ([Result]?) -> Void, apiType: T) {
        NetworkService.getNews(apiType: apiType as! String ) { news in
            completion(news.results ?? [])
        }
        
    }
    func pushDetailNews(view: UIViewController, news: Result){
            navigator.pushDetailNews(from: view, news: news)
        }
    }
