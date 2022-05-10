//
//  UIHelper.swift
//  GHFollowers
//
//  Created by mohsen on 06/05/2022.
//

import UIKit
struct UIHelper {
    static func createThreeColumnFlowLayout(in view : UIView) -> UICollectionViewFlowLayout{
        let width                               = view.bounds.width
        let padding : CGFloat                   = 12
        let minimumItemSpasing : CGFloat        = 10
        let avalableWidth                       = width - (padding * 2) - (minimumItemSpasing * 2)
        let itemWidth                           = avalableWidth / 3
        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize     = CGSize(width: itemWidth, height: itemWidth + 40)
        
        
        return  flowLayout
    }
}
