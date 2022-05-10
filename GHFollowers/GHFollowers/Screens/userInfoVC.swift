//
//  userInfoVC.swift
//  GHFollowers
//
//  Created by mohsen on 06/05/2022.
//

import UIKit
 
protocol userInfoVCDelegate : class{
    func didTapGitHubProfile(for user : User)
    func didTapGetFollowers(for user : User)
}

class userInfoVC: UIViewController {
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTow = UIView()
    let dataLable = GFbodyLable(textAalignment: .center)
    
    var itemViews : [UIView] = []
    
    var username : String!
    weak var delegate : FollowerListVCDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        configuerViewController()
        layoutUI()
        getUserInfo()


      
        
    }
    
    func configuerViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func getUserInfo(){
        NetworkManager.shared.getusers(for: username) {[weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let user):
                DispatchQueue.main.async {self.configuerElements(with: user)}
                print("sssssssssssssss\(user)")
            case .failure(let error):
                self.presentGFlertOnMainThread(title: "Somsthing went wrong", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }
    
    
    
    func configuerElements(with user : User){
        let repoItemVC          = GFRepoItemVC(user: user)
        repoItemVC.delegate     = self
        
        let followerItemVC      = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTow)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dataLable.text = "GitHub Since \(user.createdAt.convertToDisplayFormat())"
    }
    
    
    func layoutUI(){
        
        itemViews = [headerView , itemViewOne , itemViewTow , dataLable]
        
        for itemView in itemViews{
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
    
        let padding : CGFloat = 20
        let itemHeight : CGFloat = 140
        NSLayoutConstraint.activate([
        
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor ),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor , constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            
            itemViewTow.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor , constant: padding),
            itemViewTow.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: padding),
            itemViewTow.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -padding),
            itemViewTow.heightAnchor.constraint(equalToConstant: itemHeight),
            
            
            dataLable.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: padding),
            dataLable.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -padding),
            dataLable.topAnchor.constraint(equalTo: itemViewTow.bottomAnchor , constant: padding),
            dataLable.heightAnchor.constraint(equalToConstant: 18)

        
        ])
    }
    
    
    func add(childVC : UIViewController , to containerView : UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
}


extension userInfoVC : userInfoVCDelegate{
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else{
            presentGFlertOnMainThread(title: "Invalid URl", message: "the URl attached to this user is invalid", buttonTitle: "ok")
            return
        }
        
        
  presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        
        guard user.followers != 0 else{
            presentGFlertOnMainThread(title: "No followers", message: "this user has ni followers. what a shame 🙃", buttonTitle: "So sad")
            return

        }
        delegate.didRquestFollowers(for: user.login)
        dismissVC()
    }
    
 
    
}
