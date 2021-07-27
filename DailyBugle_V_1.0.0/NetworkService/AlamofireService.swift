//
//  AlamofireService.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 16.07.2021.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    static  func getNews(apiType:String, completion: @escaping (News) -> Void)
}


class NetworkService: NetworkServiceProtocol {
    static func getNews(apiType: String, completion: @escaping (News) -> Void) {
     
        let urlParams = [
            "api-key": "cBzLTGjH2cSpHe4v3sjWED8OqItssAUZ"
        ]
        guard let url = URL(string: ApiType.baseURL + apiType) else {return}

        AF.request(url, parameters: urlParams).responseJSON { (response) in

            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let news: News = try decoder.decode(News.self, from: data)
                    completion(news)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
