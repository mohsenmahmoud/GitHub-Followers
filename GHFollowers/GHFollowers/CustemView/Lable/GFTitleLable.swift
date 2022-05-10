//
//  GFTitleLable.swift
//  GHFollowers
//
//  Created by mohsen on 06/04/2022.
//

import UIKit

class GFTitleLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configuer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment , fontSize : CGFloat){
        super.init(frame: .zero)
        self.textAlignment          = textAlignment
        self.font                   = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        
        
        configuer()
    }
    
    private func configuer(){
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
