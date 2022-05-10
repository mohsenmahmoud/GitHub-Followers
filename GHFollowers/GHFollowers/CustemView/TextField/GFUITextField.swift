//
//  GFUITextField.swift
//  GHFollowers
//
//  Created by mohsen on 29/03/2022.
//

import UIKit

class GFUITextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configuer(){
        translatesAutoresizingMaskIntoConstraints  = false
        layer.cornerRadius           = 10
        layer.borderWidth            = 2
        layer.borderColor            = UIColor.systemGray4.cgColor
        
        textColor                    = .label
        tintColor                    = .label
        textAlignment                = .center
        font                         = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth    = true
        minimumFontSize              = 12
        
        backgroundColor              = .tertiarySystemBackground
        autocorrectionType           = .no
        returnKeyType                = .go
        placeholder                  = "Enter U name"
    }
    
}
