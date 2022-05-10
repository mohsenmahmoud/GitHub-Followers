//
//  favoritesListViewController.swift
//  GHFollowers
//
//  Created by mohsen on 25/03/2022.
//

import UIKit

class favoritesListViewController: UIViewController {
    let tableView = UITableView()
    var favorites : [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configuerViewController()
        configuerTableView()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorite()
    }
    
    
    func configuerViewController(){
      
        view.backgroundColor = .systemBackground
        title       = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func configuerTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight  = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(favoriteCell.self, forCellReuseIdentifier: favoriteCell.reuseID)
    }
    
    
    func getFavorite(){
        persisttenManager.retrieveFavorites {[weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let favorites):
                if favorites.isEmpty{
                    self.showEmptyStateView(with: "No Favorites ?\nAdd one on the follower Screen.", in: self.tableView)
                }else{
                    self.favorites = favorites
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                        
                    }
                }

            case .failure(let error):
                self.presentGFlertOnMainThread(title: "somsething went wrong", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }
}


extension favoritesListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCell.reuseID, for: indexPath) as! favoriteCell
        let favorit = favorites[indexPath.row]
        cell.set(favorite: favorit) 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorit = favorites[indexPath.row]
       let decVC = FollowerListVC()
       decVC.username = favorit.login
       decVC.title     = favorit.login
        navigationController?.pushViewController(decVC, animated: true)
    }
    

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else{return}
        let favorit = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        persisttenManager.updateWith(favorite: favorit, actionType: .remove) {[weak self] error in
            guard let self = self else{return}
            guard let error = error else {return}
            self.presentGFlertOnMainThread(title: "Unable to remove ", message: error.rawValue, buttonTitle: "ok")
        }
        
        
        
    }
 
    
    
}
