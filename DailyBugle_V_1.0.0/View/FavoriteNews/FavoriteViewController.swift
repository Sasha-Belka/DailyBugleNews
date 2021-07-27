//
//  FavoriteViewController.swift
//  DailyBugle_V_1.0.0
//
//  Created by Oleksandr Kostogryz on 19.07.2021.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: FavoriteNewsPresenter!
    
    var news: [FavoriteNews]?
    let data = FavoriteData()
    init(presenter: FavoriteNewsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                                
                self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
                self.tableView.delegate = self
                self.tableView.dataSource = self
                setupUI()
            }
        override func viewWillAppear(_ animated: Bool) {
        reload()
            }
        }

            //MARK: Tableview delegate and datasource

        extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                self.news?.count ?? 0
                
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
                    let favorite = self.news?[indexPath.row]
                    cell.MyLabel.text = favorite?.headTitle
                    return cell
                }
                    return UITableViewCell()
                }
            func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                let action = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, comletionHandler) in
                    let cellToRemove = news![indexPath.row]
                    data.remove(cellToRemove: cellToRemove)
                    reload()
                }
                return UISwipeActionsConfiguration(actions: [action])
            }
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: false)
                guard let favorite = news?[indexPath.row] else { return }
                presenter.pushLocalNews(view: self, favorite: favorite)
            }
            

            func setupUI(){
                tableView.separatorColor = UIColor.systemYellow
                navigationController?.navigationBar.barTintColor = .black
                navigationController?.navigationBar.tintColor = .white
            }
           func reload() {
                data.fetchFavorite(tableView: tableView)
                news = data.favorites
            }
    }



