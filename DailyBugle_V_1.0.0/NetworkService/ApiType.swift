//
//  ApiType.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 19.07.2021.
//

import Foundation

enum ApiType {

    static var baseURL = "https://api.nytimes.com/svc/mostpopular/v2"

    case getEmailedNews
    case getViewedNews
    case getSharedNews

    var stringValue: String {
        switch self {

        case .getEmailedNews: return "/emailed/30.json"
        case .getViewedNews: return "/viewed/30.json"
        case .getSharedNews: return "/shared/30.json"
        }
    }
}
