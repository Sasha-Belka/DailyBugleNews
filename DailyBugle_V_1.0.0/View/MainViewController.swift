//
//  MainViewController.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 19.07.2021.
//

import UIKit

class MainViewController: UIViewController, UITabBarControllerDelegate  {
    
    private var embedTabBarVC: UITabBarController = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupTabBar()
    }
}

extension MainViewController {
    
    func SetupTabBar() {
        embedTabBarVC.viewControllers = [instantiateMostViewedVC(), instantiateMostEmailedVC(), instantiateMostSharedVC(), instantiateFavoriteVC()]
        embedTabBarVC.tabBar.barTintColor = .systemYellow
        embedTabBarVC.tabBar.unselectedItemTintColor = .black
        embedTabBarVC.tabBar.tintColor = .white
        self.navigationController?.isNavigationBarHidden = true
        addChildViewControllerToView(embedTabBarVC, toContainer: view)
    }
    func instantiateMostViewedVC() -> UINavigationController {
        let apiType = ApiType.getViewedNews.stringValue
        let presenter = NewsViewPresenter()
        let vc: NewsViewController = NewsViewController(presenter: presenter, apiType: apiType)
        let navigationVc = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(
            title: "Most Viewed News", image: UIImage(systemName: "mail.stack"), selectedImage: UIImage(systemName: "mail.stack"))
        return navigationVc
    }
    func instantiateMostEmailedVC() -> UINavigationController {
        let apiType = ApiType.getEmailedNews.stringValue
        let presenter = NewsViewPresenter()
        let vc: NewsViewController = NewsViewController(presenter: presenter, apiType: apiType)
        let navigationVc = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(
            title: "Most Emailed News", image: UIImage(systemName: "paperplane"), selectedImage: UIImage(systemName: "paperplane"))
        return navigationVc
    }
    func instantiateMostSharedVC() -> UINavigationController {
        let apiType = ApiType.getSharedNews.stringValue
        let presenter = NewsViewPresenter()
        let vc: NewsViewController = NewsViewController(presenter: presenter, apiType: apiType)
        let navigationVc = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(
            title: "Most Shared News", image: UIImage(systemName: "globe"), selectedImage: UIImage(systemName: "globe"))
        return navigationVc
    }
    func instantiateFavoriteVC() -> UINavigationController {
        let vc: FavoriteViewController = FavoriteViewController()
        let navigationVc = UINavigationController(rootViewController: vc)
        vc.tabBarItem = UITabBarItem(
            title: "Favorite News", image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
        return navigationVc
    }
}
