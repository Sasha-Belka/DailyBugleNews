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
    
    private var searchBarIsEmpty: Bool {
        guard let text = seacrhController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return seacrhController.isActive && !searchBarIsEmpty
    }
    
    let seacrhController = UISearchController(searchResultsController: nil)
    
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
    var filteredNews: [Result]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: tableViewCell, bundle: nil), forCellReuseIdentifier: CellReuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupSearchControllerUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNews()
        setupUI()
    }
}

    //MARK: Tableview delegate and datasource

extension NewsViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredNews?.count ?? 0
        }
        return allNews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var news: Result?
    
        if isFiltering {
             news = (filteredNews?[indexPath.item])
        } else {
             news = (allNews?[indexPath.item])
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier, for: indexPath)
            as? NewsCell
        setupData(cell: cell, news: news)
        return cell!
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let favorite = FavoriteNews()
        let newsType = "SetupDetailNews"
        
        let news: Result?
        
        if isFiltering {
             news = (filteredNews?[indexPath.item])
        } else {
             news = (allNews?[indexPath.item])
        }
        pushDetailNews(news: news, favorite: favorite, newsType: newsType)
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: SearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filteredContentForSearchText(_ searchText: String){
        filteredNews = allNews?.filter({ (news: Result) -> Bool in
            return (news.title?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
    //MARK: Setup UI, GetNews, SetupData, SetupSearch
    
    func pushDetailNews(news: Result?, favorite: FavoriteNews, newsType: String) {
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
        view.backgroundColor = .systemYellow
        self.tabBarController?.tabBar.isHidden = false
        tableView.separatorColor = UIColor.systemYellow
        navigationController?.navigationBar.barTintColor = .systemYellow
        navigationController?.navigationBar.tintColor = .black
        let addButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(seacrh))
        addButton.image = UIImage()
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.title = "DailyBugle"
    }
    func setupData(cell: NewsCell?, news: Result?){
        cell?.titleLabel.text = news?.title
        if ((news?.media?.count) != 0) {
        let url = URL(string: news?.media?[0].mediametadata?[2].url ?? "https://theimageconference.org/wp-content/uploads/2021/02/online_conference_bcteal__image_conference.png")
        cell?.newsImage.kf.setImage(with: url)
        }
    }
    func setupSearchControllerUI(){
        seacrhController.searchResultsUpdater = self // Свойство говорит, что получатель информации об изменении текста в поисковой строке должен быть наш класс
        seacrhController.obscuresBackgroundDuringPresentation = false // По умолчании ВьюКонтроллер с результатами поиска не позволяет взаимодействовать с отображаемыс контентом, он его просто затемняет, и для того, чтобы мы смогли взаимодействовать с отфильтрованым результатом как с основным мы и присваивам фолс.
        seacrhController.searchBar.placeholder = "Search..."
        definesPresentationContext = true // Позволяет отпустить строку поиска пре переходе на другой экран
        seacrhController.searchBar.barTintColor = .systemYellow
        seacrhController.searchBar.tintColor = .black
        seacrhController.searchBar.isTranslucent = false
        navigationItem.searchController = seacrhController
    }
    @objc func seacrh() {
        present(seacrhController, animated: true, completion: nil)
    }
}



