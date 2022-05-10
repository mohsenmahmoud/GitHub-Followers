//
//  searchViewController.swift
//  GHFollowers
//
//  Created by mohsen on 25/03/2022.
//

import UIKit

class searchViewController: UIViewController {
    let logoImage = UIImageView()
    let textFild = GFUITextField()
    let callToAction = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUserNameEntred : Bool{return !textFild.text!.isEmpty}

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configurLogoImageView()
        configurTextField()
        confgurCallButton()
        createdismisKeywordTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
   @objc func pushFollowerListVC(){
       guard isUserNameEntred else{
          presentGFlertOnMainThread(title: "Empty User Name", message: "Please enter a user name . we need to know who to look for 😄.", buttonTitle: "Ok")
           return
           
       }
        let followervcList = FollowerListVC()
       followervcList.username = textFild.text
       followervcList.title = textFild.text
       navigationController?.pushViewController(followervcList, animated: true)
    }
    
    func createdismisKeywordTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    
    func configurLogoImageView(){
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200 )
        
        ])
    }
    
    
   func configurTextField(){
        
       view.addSubview(textFild)
       textFild.delegate = self
       NSLayoutConstraint.activate([
        textFild.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 48),
        textFild.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        textFild.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        textFild.heightAnchor.constraint(equalToConstant: 50)
       
       ])
    }
    
    
    func confgurCallButton(){
        
        view.addSubview(callToAction)
        callToAction.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToAction.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            callToAction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToAction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToAction.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
    }
    

 

}


extension searchViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
