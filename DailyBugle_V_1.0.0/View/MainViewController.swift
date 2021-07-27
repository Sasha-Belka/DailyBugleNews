//
//  MainViewController.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 19.07.2021.
//

import UIKit

class MainViewController: UITabBarController {
    
    private lazy var mostEmailedController: UINavigationController =  instantiateMostEmailedVC()
    private lazy var mostViewedController: UINavigationController =  instantiateMostViewedVC()
    private lazy var favoriteController: UINavigationController =  instantiateFavoriteVC()
    private lazy var mostSharedController: UINavigationController =  instantiateMostSharedVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupTabBar()
    }
}

extension MainViewController {
    
    func SetupTabBar() {
     viewControllers = [mostViewedController, mostEmailedController, mostSharedController, favoriteController]
     tabBar.barTintColor = .systemYellow
     tabBar.unselectedItemTintColor = .black
     tabBar.tintColor = .white
     tabBar.isTranslucent = false
     navigationItem.title = "Daily Bugle"
    }
    
    func setSelectedIndex(index: Int) {
        selectedIndex = index
    }

    
    func instantiateMostEmailedVC() -> UINavigationController {
        let navigator = NewsNavigatorImpl()
        let apiType = ApiType.getEmailedNews.stringValue
        let presenter = NewsViewPresenter(navigator: navigator)
        let vc: NewsViewController = NewsViewController(presenter: presenter, apiType: apiType)
        let navigationVc = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(
            title: "Most Emailed News", image: UIImage(systemName: "paperplane"), selectedImage: UIImage(systemName: "paperplane"))
        return navigationVc
    }
    func instantiateMostViewedVC() -> UINavigationController {
        let navigator = NewsNavigatorImpl()
        let apiType = ApiType.getViewedNews.stringValue
        let presenter = NewsViewPresenter(navigator: navigator)
        let vc: NewsViewController = NewsViewController(presenter: presenter, apiType: apiType)
        let navigationVc = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(
            title: "Most Viewed News", image: UIImage(systemName: "mail.stack"), selectedImage: UIImage(systemName: "mail.stack"))
        return navigationVc
    }
    func instantiateFavoriteVC() -> UINavigationController {
        let navigator = NewsNavigatorImpl()
        let presenter = FavoriteNewsImpl(navigator: navigator)
        let vc: FavoriteViewController = FavoriteViewController(presenter: presenter)
        let navigationVc = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(
            title: "Favorite News", image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
        return navigationVc
    }
    func instantiateMostSharedVC() -> UINavigationController {
        let navigator = NewsNavigatorImpl()
        let apiType = ApiType.getSharedNews.stringValue
        let presenter = NewsViewPresenter(navigator: navigator)
        let vc: NewsViewController = NewsViewController(presenter: presenter, apiType: apiType)
        let navigationVc = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(
            title: "Most Shared News", image: UIImage(systemName: "globe"), selectedImage: UIImage(systemName: "globe"))
        return navigationVc
    }

}
