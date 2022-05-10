//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by mohsen on 08/05/2022.
//
import UIKit

class GFFollowerItemVC : GFItemInfoVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        configuerItem()
    }
    
    
    private func configuerItem(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        
        actionButton.set(backgroundColor: .systemPurple, title: "Get Followers")

    }
    
    
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
