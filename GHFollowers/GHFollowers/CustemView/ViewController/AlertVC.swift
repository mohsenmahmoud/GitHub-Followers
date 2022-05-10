//
//  AlertVC.swift
//  GHFollowers
//
//  Created by mohsen on 20/04/2022.
//

import UIKit

class AlertVC: UIViewController {
    
    
    let containerView       = UIView()
    let titleLable          = GFTitleLable(textAlignment: .center, fontSize: 20)
    let messageLable        = GFbodyLable(textAalignment: .center)
    let actionButton        = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle : String?
    var message : String?
    var buttonTitle : String?
    
    
    var padding : CGFloat = 20
    
    init(title : String , message : String , buttonTitle : String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLable()
        configureActionButton()
        configureMessageTitle()

        // Do any additional setup after loading the view.
    }
    
    
    func configureContainerView(){
        view.addSubview(containerView)
        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .systemBackground
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
        
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 240)
        ])
        
    }
    
    
    func configureTitleLable(){
        containerView.addSubview(titleLable)
        titleLable.text = alertTitle ?? "something went wrong"

        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLable.heightAnchor.constraint(equalToConstant: 28)
        
        ])
        
    }
    
    
    
    func configureActionButton(){
        
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismisVC), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor , constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        
        ])
    }
    
  @objc func dismisVC(){
        dismiss(animated: true)
    }
    
    
    
    func configureMessageTitle(){
        
        containerView.addSubview(messageLable)
        messageLable.text = message ?? "unble to complete request"
        messageLable.numberOfLines = 4
        
        
        NSLayoutConstraint.activate([
            messageLable.topAnchor.constraint(equalTo: titleLable.topAnchor, constant: 8),
            messageLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLable.bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: -12)
        
        ])
    }
    
 

}
