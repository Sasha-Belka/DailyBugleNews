//
//  MostViewedPresenter.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 16.07.2021.
//

import UIKit

protocol NewsViewPresenterProtocol : class {
    func getNews<T>(completion: @escaping ([Result]?) -> Void, apiType: T)
}

final class NewsViewPresenter: NewsViewPresenterProtocol {
   
    func getNews<T>(completion: @escaping ([Result]?) -> Void, apiType: T) {
        NetworkService.getNews(apiType: apiType as! String ) { news in
            completion(news.results ?? [])
        }
    }
}
