//
//  LoadingView.swift
//  Created by Ali Hassan on 16/12/2018.
//

import Foundation
import UIKit
import TinyConstraints

class LoadingView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let temp = UIActivityIndicatorView(style: .whiteLarge)
        temp.color = .black
        temp.startAnimating()
        return temp
    }()
    
    private let loadingLabel: UILabel = {
        let temp = UILabel()
        temp.text = "Loading data"
        temp.textAlignment = .center
        temp.font = Font.seventeenRegular
        temp.textColor = .black
        return temp
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        privateInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        privateInit()
    }
    
    private func privateInit() {
        addSubview(loadingLabel)
        loadingLabel.centerXToSuperview()
        loadingLabel.centerYToSuperview(offset: -30)
        
        addSubview(activityIndicator)
        activityIndicator.centerXToSuperview()
        activityIndicator.topToBottom(of: loadingLabel, offset: 32)
    }
    
}
