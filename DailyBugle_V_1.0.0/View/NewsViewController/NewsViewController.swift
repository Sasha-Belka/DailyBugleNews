//
//  NewsViewController.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 16.07.2021.
//

import UIKit
import Kingfisher

class NewsViewController: UIViewController {
    
    private let tableViewCell = "NewsCell"
    private let CellReuseIdentifier = "cell"
    
    private  var presenter: NewsViewPresenterProtocol!
    private var apiType: String
    init(presenter: NewsViewPresenterProtocol, apiType: String) {
        self.presenter = presenter
        self.apiType = apiType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    @IBOutlet weak var tableView: UITableView!
    var allNews: [Result]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: tableViewCell, bundle: nil), forCellReuseIdentifier: CellReuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNews()
        setupUI()
    }
}

    //MARK: Tableview delegate and datasource

extension NewsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allNews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let news = (allNews?[indexPath.item])
            let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier, for: indexPath)
                as? NewsCell
            setupData(cell: cell, news: news)
            return cell!
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let news = allNews?[indexPath.row] else { return }
        let favorite = FavoriteNews()
        let newsType = "SetupDetailNews"
        pushDetailNews(news: news, favorite: favorite, newsType: newsType)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    //MARK: Func
    
    func pushDetailNews(news: Result, favorite: FavoriteNews, newsType: String) {
        let viewController = DetailNewsViewController(news: news, favorite: favorite, newsType: newsType)
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    func getNews() {
        presenter.getNews(completion: { [weak self] news in
            self?.allNews = news
            self?.tableView.reloadData()
        },  apiType: apiType )
    }
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = false
        tableView.separatorColor = UIColor.systemYellow
        navigationController?.navigationBar.barTintColor = .systemYellow
        navigationController?.navigationBar.tintColor = .black
    }
    func setupData(cell: NewsCell?, news: Result?){
        cell?.titleLabel.text = news?.title
        if ((news?.media?.count) != 0) {
        let url = URL(string: news?.media?[0].mediametadata?[2].url ?? "https://theimageconference.org/wp-content/uploads/2021/02/online_conference_bcteal__image_conference.png")
        cell?.newsImage.kf.setImage(with: url)
        }
    }
}



