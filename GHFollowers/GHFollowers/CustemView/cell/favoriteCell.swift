//
//  favoriteCell.swift
//  GHFollowers
//
//  Created by mohsen on 08/05/2022.
//

import UIKit

class favoriteCell: UITableViewCell {

    static let reuseID = "favoriteCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userNamelable = GFTitleLable(textAlignment: .left, fontSize: 26)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configuer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func set(favorite : Follower){
        userNamelable.text = favorite.login
        avatarImageView.downloadImage(from: favorite.avatarUrl)
    }
    
    
    private func configuer(){
        addSubview(avatarImageView)
        addSubview(userNamelable)
        
        accessoryType  = .disclosureIndicator
        
        let padding : CGFloat = 12
        
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            
            
            userNamelable.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userNamelable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor , constant: 24),
            userNamelable.trailingAnchor.constraint(equalTo:self.trailingAnchor , constant: -padding),
            userNamelable.heightAnchor.constraint(equalToConstant: 40),
        
        ])
    }

}
