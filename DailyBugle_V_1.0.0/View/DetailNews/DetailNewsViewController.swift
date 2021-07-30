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
    var favorite: FavoriteNews
    let newsType: Int
    private  var presenter: DetailNewsPresenterImpl!
    init(news: Result, presenter: DetailNewsPresenterImpl, favorite: FavoriteNews, newsType: Int) {
        self.news = news
        self.favorite = favorite
        self.presenter = presenter
        self.newsType = newsType
        super.init(nibName: "DetailNewsViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if newsType == 0 { setupLocalNews()
            
        } else {
            setupDetailNews()
            
        }
    }
}

extension DetailNewsViewController {
    func setupDetailNews() {
        self.tabBarController?.tabBar.isHidden = true
        if ((news.media?.count) != 0) {
            guard let url = URL(string: (news.media?[0].mediametadata?[2].url ?? "https://static01.nyt.com/images/2021/07/20/well/physed-walking-denver/physed-walking-denver-mediumThreeByTwo440-v2.jpg")) else {return}
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
            guard let url = URL(string: (favorite.imageUrl ?? "https://static01.nyt.com/images/2021/07/20/well/physed-walking-denver/physed-walking-denver-mediumThreeByTwo440-v2.jpg")) else {return}
            newsImage.kf.setImage(with: url)}
        headTitle.text = favorite.headTitle
        sourceLabel.text = "Source: " + (favorite.source ?? "-")
        sectionLabel.text = "Section: " + (favorite.section ?? "-")
       // idLabel.text = "Id: \(news.id ?? 0)"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavorite))
        addButton.image = UIImage()
        self.navigationItem.rightBarButtonItem = addButton
            }

   @objc func addFavorite() {
        let addFavorite = FavoriteData()
        if ((news.media?.count) != 0) {
            addFavorite.saveFavoriteNews(headTitle: news.title, source: news.source, section: news.section, id: news.id, imageUrl: news.media?[0].mediametadata?[2].url ?? "https://static01.nyt.com/images/2021/07/20/well/physed-walking-denver/physed-walking-denver-mediumThreeByTwo440-v2.jpg")
            message(new: title, viewController: self)
            
        } else {
        addFavorite.saveFavoriteNews(headTitle: news.title, source: news.source, section: news.section, id: news.id, imageUrl: "https://static01.nyt.com/images/2021/07/20/well/physed-walking-denver/physed-walking-denver-mediumThreeByTwo440-v2.jpg")
            message(new: title, viewController: self)}
    }
    func message(new: String?, viewController: UIViewController){
        let alert = UIAlertController(title: new, message: "Saved", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        viewController.present(alert, animated: true, completion: nil)
    }
}
