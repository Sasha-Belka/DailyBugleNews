//
//  FavoriteViewController.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 19.07.2021.
//

import UIKit
import Kingfisher

class FavoriteViewController: UIViewController {
    
    private let tableViewCell = "NewsCell"
    private let CellReuseIdentifier = "cell"

    @IBOutlet weak var tableView: UITableView!
    
    var favoriteNews: [FavoriteNews]?
    let data = FavoriteData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                                
                self.tableView.register(UINib(nibName: tableViewCell, bundle: nil), forCellReuseIdentifier: CellReuseIdentifier)
                self.tableView.delegate = self
                self.tableView.dataSource = self
                
            }
    override func viewWillAppear(_ animated: Bool) {
            reload()
            setupUI()
            }
        }

            //MARK: Tableview delegate and datasource

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                self.favoriteNews?.count ?? 0
                
            }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                if let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier, for: indexPath) as? NewsCell {
                    let favorite = self.favoriteNews?[indexPath.row]
                    setupData(cell: cell, favorite: favorite)
                    return cell
                }
                    return UITableViewCell()
                }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                let action = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, comletionHandler) in
                    let cellToRemove = favoriteNews![indexPath.row]
                    data.removeCell(cellToRemove: cellToRemove)
                    reload()
                }
                return UISwipeActionsConfiguration(actions: [action])
            }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: false)
                guard let favorite = favoriteNews?[indexPath.row] else { return }
                let jsonNews = Result()
                let newsType = "SetupLocalNews"
                pushDetailNews(news: jsonNews, favorite: favorite, newsType: newsType)
            }
            
    //MARK: Func
    func setupUI(){
                self.tabBarController?.tabBar.isHidden = false
                tableView.separatorColor = UIColor.systemYellow
                navigationController?.navigationBar.barTintColor = .systemYellow
                navigationController?.navigationBar.tintColor = .black
            }
    func reload() {
                data.fetchFavorite(tableView: tableView)
                favoriteNews = data.favorites
            }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 100
            }
            
    func pushDetailNews(news: Result, favorite: FavoriteNews, newsType: String) {
                let viewController = DetailNewsViewController(news: news, favorite: favorite, newsType: newsType)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
    func setupData(cell: NewsCell?, favorite: FavoriteNews?){
                cell?.titleLabel.text = favorite?.headTitle
                let url = URL(string: favorite?.imageUrl ?? "https://theimageconference.org/wp-content/uploads/2021/02/online_conference_bcteal__image_conference.png")
                cell?.newsImage.kf.setImage(with: url)
    }
}



