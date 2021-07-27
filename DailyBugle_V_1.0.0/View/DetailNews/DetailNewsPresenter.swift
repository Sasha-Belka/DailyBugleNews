//
//  DetailNewsPresenter.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 20.07.2021.
//

import UIKit

protocol DetailNewsProtocol: class {
    
}

final class DetailNewsPresenterImpl {

    let navigator: NewsNavigatorImpl

    init(navigator: NewsNavigatorImpl) {
        self.navigator = navigator
    }
    func message(new: String?, viewController: UIViewController){
        let alert = UIAlertController(title: new, message: "Saved", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        viewController.present(alert, animated: true, completion: nil)
    }
    func handleSwipeGestureLeft(sender: UISwipeGestureRecognizer, news:[Result]?, index: Int, viewController: UIViewController) {
        if (news?.endIndex != index+1) {
        let swipeIndex = news?.index(index , offsetBy: 1)
        let vc = DetailNewsViewController(news: news, index: swipeIndex ?? index, presenter: self)
        viewController.navigationController?.pushViewController(vc, animated: true)
        }}
    func handleSwipeGestureRight(sender: UISwipeGestureRecognizer, news:[Result]?, index: Int, viewController: UIViewController) {
        if (news?.endIndex != index) {
        let swipeIndex = news?.index(index , offsetBy: -1)
        let vc = DetailNewsViewController(news: news, index: swipeIndex ?? index, presenter: self)
        viewController.navigationController?.pushViewController(vc, animated: false)
        }}
}
