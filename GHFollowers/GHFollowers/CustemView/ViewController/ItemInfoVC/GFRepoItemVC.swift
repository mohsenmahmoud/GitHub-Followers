//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by mohsen on 08/05/2022.
//

import UIKit

class GFRepoItemVC : GFItemInfoVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        configuerItem()
    }
    
    
    private func configuerItem(){
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gits, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemGreen, title: "GitHub Profile")

    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
