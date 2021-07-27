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
}
