//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by mohsen on 02/04/2022.
//

import UIKit
protocol FollowerListVCDelegate : class {
    func didRquestFollowers(for username : String)
}

class FollowerListVC: UIViewController {
    
    var followers : [Follower] = []
    
    
    enum Section{
        case main
    }
    
    var collectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section , Follower>!
    
    var username : String!
    var isSearching = false
    var filterFollowers : [Follower] = []
    var page  = 1
    var hasMoreFollower = true

    override func viewDidLoad() {
        super.viewDidLoad()
        configuerViewController()
        configuerCollectionView()
        getFollower(username: username, page: page)
        configuerDataSurce()
         configuerUISearchController()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configuerViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    //search controller
    func configuerUISearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "search for a username"
        searchController.obscuresBackgroundDuringPresentation   = false
        searchController.searchBar.delegate                     = self
        navigationItem.searchController                         = searchController
    }
    
    
    
    
    func configuerCollectionView(){
        collectionView = UICollectionView(frame:view.bounds,collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
            view.addSubview(collectionView)
        collectionView.delegate = self
        
        collectionView.backgroundColor          = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    

    
    func getFollower(username : String , page : Int){
        showLoadingView()

        NetworkManager.shared.getFollower(for: username, page: 1) {[weak self] result in
            
            guard let self = self else{return}
            self.dismissLoadingView()
            switch result{
            case .success(let followers):
                if followers.count < 100 {self.hasMoreFollower = false}
                self.followers.append(contentsOf: followers)
                
                if followers.isEmpty{
                    let message = "this user dosn't have followers . Go follow them 😄"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                self.ubdateData(on: self.followers)
            case .failure(let error):
                self.presentGFlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
         

        }
    }
    
    func configuerDataSurce(){
        dataSource = UICollectionViewDiffableDataSource<Section , Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower)-> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func ubdateData(on followers : [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section , Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)

        DispatchQueue.main.async {
          
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    @objc func addButtonTapped(){
      
        showLoadingView()
        
        NetworkManager.shared.getusers(for: username) {[weak self] result in
            guard let self = self else{return}
            
            self.dismissLoadingView()
            
            switch result{
            case .success(let user):
                
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                
                persisttenManager.updateWith(favorite: favorite, actionType: .add) {[weak self] error in
                    guard let self = self else {return}
                    
                    guard let error = error else {
                        self.presentGFlertOnMainThread(title: "Succses!", message: "you have Succsesfully favorited this user 🎉", buttonTitle: "Hooray!")
                        return
                    }
                    self.presentGFlertOnMainThread(title: "somsething went wrong", message: error.rawValue, buttonTitle: "ok")

                }
                
                
                
            case .failure(let error):
                self.presentGFlertOnMainThread(title: "somsething went wrong", message: error.rawValue, buttonTitle: "ok")
                
            }
        }
        
        
        
        
    }
     

}



extension FollowerListVC : UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        
        print("offSetY \(offSetY)")
        print("contentHeight \(contentHeight)")
        print("height \(height)")
        
        if offSetY > contentHeight - height {
            guard hasMoreFollower else{return}
            page += 1
            getFollower(username: username, page: page)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filterFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let decVC = userInfoVC()
        decVC.username = follower.login
        decVC.delegate  = self
        let navController = UINavigationController(rootViewController: decVC)
        present(navController, animated: true)
    }
}


extension FollowerListVC : UISearchResultsUpdating , UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else {return}
        isSearching = true
        filterFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        
        ubdateData(on: filterFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        ubdateData(on: followers)
    }
    
    
}



extension FollowerListVC :FollowerListVCDelegate{
    func didRquestFollowers(for username: String) {
        //get followers
        self.username   = username
        title           = username
        page      = 1
        followers.removeAll()
        filterFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollower(username: username, page: page)
    }
    
    
}
