//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by mohsen on 06/05/2022.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userNameLable   = GFTitleLable(textAlignment: .left, fontSize: 34)
    let nameLable       = GFSecondaryTitleLable(fontSize: 18)
    let locationImageVIew = UIImageView()
    let locationLable   = GFSecondaryTitleLable(fontSize: 18)
    let biolable        = GFbodyLable(textAalignment: .left)
    
    var user : User!
    
    init(user : User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        layoutUI()
        configuerUIElement()

        // Do any additional setup after loading the view.
    }
    
    
    func configuerUIElement(){
        //avatarImageView.downloadImage(from: user.avatarUrl)
        avatarImageView.downloadImage(from: user.avatarUrl)
        userNameLable.text  = user.login
        nameLable.text      = user.name ?? ""
        locationLable.text  = user.location ?? ""
        biolable.text       = user.bio ?? ""
        biolable.numberOfLines = 3
        
        locationImageVIew.image = UIImage(systemName: "mappin.and.ellipse")
        locationImageVIew.tintColor = .secondaryLabel
        
    }
    
    
    func addSubViews(){
        view.addSubview(avatarImageView)
        view.addSubview(userNameLable)
        view.addSubview(nameLable)
        view.addSubview(locationImageVIew)
        view.addSubview(locationLable)
        view.addSubview(biolable)
        
    }
    
    
    func layoutUI(){
        
        let padding : CGFloat = 20
        let textImagePadding : CGFloat = 12
        locationImageVIew.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
        
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor , constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            
            
            userNameLable.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            userNameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor , constant: textImagePadding),
            userNameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -padding),
            userNameLable.heightAnchor.constraint(equalToConstant: 38),
            
            
            
            
            nameLable.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor , constant: 8),
            nameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor , constant: textImagePadding),
            nameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -padding),
            nameLable.heightAnchor.constraint(equalToConstant: 20),
            
            
            
            
            
            locationImageVIew.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageVIew.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor , constant: textImagePadding),
            locationImageVIew.widthAnchor.constraint(equalToConstant: 20),
            locationImageVIew.heightAnchor.constraint(equalToConstant: 20),
            
            
            
            
            locationLable.centerYAnchor.constraint(equalTo: locationImageVIew.centerYAnchor),
            locationLable.leadingAnchor.constraint(equalTo: locationImageVIew.trailingAnchor , constant: 5),
            locationLable.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -padding),
            locationLable.heightAnchor.constraint(equalToConstant: 20),
            
            
            
            biolable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor , constant: textImagePadding),
            biolable.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            biolable.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -padding),
            biolable.heightAnchor.constraint(equalToConstant: 60),
        
        ])
        
        
        
    }
     

}
