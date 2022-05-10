//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by mohsen on 08/05/2022.
//

import UIKit

enum ItemInfoType{
    case repos, gits , followers,  following
}

class GFItemInfoView: UIView {
    let symbolImageView = UIImageView()
    let titleLable = GFTitleLable(textAlignment: .left, fontSize: 14)
    let countLable = GFTitleLable(textAlignment: .center, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configuer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuer(){
        
    addSubview(symbolImageView)
        addSubview(titleLable)
        addSubview(countLable)
        
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        
        NSLayoutConstraint.activate([
        
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            
            
            titleLable.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLable.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor , constant: 12),
            titleLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLable.heightAnchor.constraint(equalToConstant: 18),
            
            
            
            countLable.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor , constant: 4),
            countLable.leadingAnchor.constraint(equalTo: self.leadingAnchor ),
            countLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLable.heightAnchor.constraint(equalToConstant: 18),
            
        
        ])
        
    }
    
    func set(itemInfoType : ItemInfoType , withCount count : Int ){
        switch itemInfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSystem.repos)
            titleLable.text = "public repos"
        case .gits:
            symbolImageView.image = UIImage(systemName: SFSystem.gists)
            titleLable.text = "public gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSystem.followers)
            titleLable.text = "public followers"
        case .following:
            symbolImageView.image = UIImage(systemName: SFSystem.following)
            titleLable.text = "public following"
        }
        
        countLable.text = String(count)
    }
    
    
    

}
