//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by mohsen on 20/04/2022.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userNamelable = GFTitleLable(textAlignment: .center, fontSize: 16)
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configuer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(follower : Follower){
        userNamelable.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }


   private func configuer(){
       contentView.addSubview(avatarImageView)
       contentView.addSubview(userNamelable)

        let padding : CGFloat = 8

        NSLayoutConstraint.activate([
           avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),





            userNamelable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            userNamelable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            userNamelable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userNamelable.heightAnchor.constraint(equalToConstant: 20),

        ])
    }
    
}
