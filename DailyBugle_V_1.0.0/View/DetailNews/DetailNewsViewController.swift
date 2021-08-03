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
    
    private let detailNibName = "DetailNewsViewController"
  
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var headTitle: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    var news: Result
    var favorite: FavoriteNews
    let newsType: String
    private  var presenter: DetailNewsPresenterImpl!
    init(news: Result, favorite: FavoriteNews, newsType: String) {
        self.news = news
        self.favorite = favorite
        self.newsType = newsType
        super.init(nibName: detailNibName, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if newsType == "SetupLocalNews" { setupLocalNews()
            
        } else {
            setupDetailNews()
            
        }
    }
}

extension DetailNewsViewController {
    func setupDetailNews() {
        self.tabBarController?.tabBar.isHidden = true
        if ((news.media?.count) != 0) {
            guard let url = URL(string: (news.media?[0].mediametadata?[2].url)!) else {return}
            newsImage.kf.setImage(with: url)}
        headTitle.text = news.title
        sourceLabel.text = "Source: " + (news.source ?? "-")
        sectionLabel.text = "Section: " + (news.section ?? "-")
        idLabel.text = "Id: \(news.id ?? 0)"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavorite))
        addButton.image = UIImage()
            self.navigationItem.rightBarButtonItem = addButton
    }
    func setupLocalNews() {
        self.tabBarController?.tabBar.isHidden = true
        if ((news.media?.count) != 0) {
            guard let url = URL(string: (favorite.imageUrl)!) else {return}
            newsImage.kf.setImage(with: url)}
        headTitle.text = favorite.headTitle
        sourceLabel.text = "Source: " + (favorite.source ?? "-")
        sectionLabel.text = "Section: " + (favorite.section ?? "-")
        idLabel.text = "Id: \(favorite.id)"
            }

    @objc func addFavorite() {
        let addFavorite = FavoriteData()
            addFavorite.saveFavoriteNews(headTitle: news.title, source: news.source, section: news.section, id: news.id, imageUrl: news.media?[0].mediametadata?[2].url!)
            message(new: title, viewController: self)
    }
    func message(new: String?, viewController: UIViewController){
        let alert = UIAlertController(title: new, message: "Saved", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        viewController.present(alert, animated: true, completion: nil)
    }
}
