//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by mohsen on 20/04/2022.
//

 import UIKit
import SafariServices
fileprivate var containerView : UIView!
extension UIViewController{
    func presentGFlertOnMainThread(title : String , message : String , buttonTitle : String){
        DispatchQueue.main.async {
             let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
        
    }
    
    
    func presentSafariVC(with url : URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        
        present(safariVC, animated: true)
    }
    
    
    func showLoadingView(){
        
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        
         UIView.animate(withDuration: 0.25) {containerView.alpha = 0.8}
        let activaityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activaityIndicator)
        activaityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
        
            activaityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activaityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        activaityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
        
    }
    
    func showEmptyStateView(with message : String , in view : UIView){
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
}
