//
//  GFbodyLable.swift
//  GHFollowers
//
//  Created by mohsen on 06/04/2022.
//

import UIKit

class GFbodyLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configuer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(textAalignment : NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment                          = textAalignment
        configuer()
    }
    private func configuer(){
        textColor                                   = .secondaryLabel
        font                                        = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.75
        lineBreakMode                               = .byCharWrapping
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
