//
//  NewsViewController.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 16.07.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
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
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                as? TableViewCell
            cell?.MyLabel.text = news?.title
            return cell!
        }
    func getNews() {
        presenter.getNews(completion: { [weak self] news in
            self?.allNews = news
            self?.tableView.reloadData()
        },  apiType: apiType )
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let news = allNews?[indexPath.row] else { return }
        let favorite = FavoriteNews()
        let newsType = 1
        presenter.pushDetailNews(view: self, news: news, favorite: favorite, newsType: newsType)
    }
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = false
        tableView.separatorColor = UIColor.systemYellow
        navigationController?.navigationBar.barTintColor = .systemYellow
        navigationController?.navigationBar.tintColor = .black
    }
}



