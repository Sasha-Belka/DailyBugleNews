//
//  DetailNewsViewController.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 20.07.2021.
//

import UIKit
import Kingfisher
import CoreData

class DetailNewsViewController: UIViewController {
  
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var headTitle: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    var news: Result
    private  var presenter: DetailNewsPresenterImpl!
    init(news: Result, presenter: DetailNewsPresenterImpl) {
        self.news = news
        self.presenter = presenter
        super.init(nibName: "DetailNewsViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavorite))
        addButton.image = UIImage()
        self.navigationItem.rightBarButtonItem = addButton
    }

}

extension DetailNewsViewController {
    func setupUI() {
      //  self.tabBarController?.tabBar.isHidden = true
        if ((news.media?.count) != 0) {
            guard let url = URL(string: (news.media?[0].mediametadata?[2].url ?? "Image not found")) else {return}
        newsImage.kf.setImage(with: url)}
        headTitle.lineBreakMode = .byWordWrapping
        headTitle.numberOfLines = 0
        headTitle.text = news.title
        sourceLabel.text = "Source: " + (news.source ?? "-")
        sectionLabel.text = "Section: " + (news.section ?? "-")
        idLabel.text = "Id: \(news.id ?? 0)"
            }
    
    @objc func addFavorite() {
        let addFavorite = FavoriteData()
        if ((news.media?.count) != 0) {
        addFavorite.saveFavoriteNews(headTitle: news.title, source: news.source, section: news.section, update: news.updated, imageUrl: news.media?[0].mediametadata?[2].url ?? "0")
            presenter.message(new: title, viewController: self)
            
        } else {
        addFavorite.saveFavoriteNews(headTitle: news.title, source: news.source, section: news.section, update: news.updated, imageUrl: "000")
            presenter.message(new: title, viewController: self)}
    }
}
