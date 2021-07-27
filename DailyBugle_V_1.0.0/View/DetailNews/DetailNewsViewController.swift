//
//  DetailNewsViewController.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 20.07.2021.
//

import UIKit
import SDWebImage
import CoreData

class DetailNewsViewController: UIViewController {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsHeadTitle: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    var news: [Result]?
    var index: Int
    private  var presenter: DetailNewsPresenterImpl!
    init(news: [Result]?, index: Int, presenter: DetailNewsPresenterImpl) {
        self.news = news
        self.index = index
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
        
        let swipeRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGestureLeft))
        swipeRecognizerLeft.direction = .left
        view.addGestureRecognizer(swipeRecognizerLeft)
        
        let swipeRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGestureRight))
        swipeRecognizerRight.direction = .right
        view.addGestureRecognizer(swipeRecognizerRight)
        /*let removeButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(addFavorite))
        addButton.image = UIImage()
        self.navigationItem.rightBarButtonItem = removeButton*/
    }

}

extension DetailNewsViewController {
    func setupUI() {
        if ((news?[index].media?.count) != 0) {
            guard let url = URL(string: (news?[index].media?[0].mediametadata?[2].url ?? "Image not found")) else {return}
            newsImage.sd_setImage(with: url, completed: nil)}
        newsHeadTitle.lineBreakMode = .byWordWrapping
        newsHeadTitle.numberOfLines = 0
       newsHeadTitle.text = news?[index].title
        sourceLabel.text = "Source: " + (news?[index].source ?? "-")
        sectionLabel.text = "Section: " + (news?[index].section ?? "-")
        updatedLabel.text = "Updated: " + (news?[index].updated ?? "-")
            }
    
    @objc func addFavorite() {
        let addFavorite = FavoriteData()
        addFavorite.saveFavoriteNews(headTitle: news?[index].title, source: news?[index].source, section: news?[index].section, update: news?[index].updated, imageUrl: news?[index].media?[0].mediametadata?[2].url ?? "0")
        presenter.message(new: title, viewController: self)
    }
    @objc func handleSwipeGestureLeft(sender: UISwipeGestureRecognizer) {
        let swipeIndex = news?.index(index , offsetBy: 1)
        let vc = DetailNewsViewController(news: news, index: swipeIndex ?? index, presenter: presenter)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func handleSwipeGestureRight(sender: UISwipeGestureRecognizer) {
        let swipeIndex = news?.index(index , offsetBy: -1)
        let vc = DetailNewsViewController(news: news, index: swipeIndex ?? index, presenter: presenter)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
