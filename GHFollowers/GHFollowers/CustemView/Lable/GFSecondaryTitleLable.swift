//
//  GFSecondaryTitleLable.swift
//  GHFollowers
//
//  Created by mohsen on 06/05/2022.
//

import UIKit
class GFSecondaryTitleLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configuer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(fontSize : CGFloat){
        super.init(frame: .zero)
        font                         = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configuer()
    }
    private func configuer(){
        textColor                                   = .secondaryLabel
         adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.90 
        lineBreakMode                               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
