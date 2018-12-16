//
//  ErrorView.swift
//  Created by Ali Hassan on 16/12/2018.
//

import Foundation
import UIKit
import TinyConstraints

class ErrorView: UIView {
    
    var buttonHandler: (() -> Void)?
    
    private lazy var retryButton: UIButton = {
        let temp = UIButton()
        temp.setTitle("Retry", for: .normal)
        temp.setTitleColor(.blue, for: .normal)
        temp.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return temp
    }()
    
    private let errorLabel: UILabel = {
        let temp = UILabel()
        temp.text = "Network failure"
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
        addSubview(errorLabel)
        errorLabel.centerXToSuperview()
        errorLabel.centerYToSuperview(offset: -30)
        
        addSubview(retryButton)
        retryButton.centerXToSuperview()
        retryButton.topToBottom(of: errorLabel, offset: 32)
    }
    
    @objc private func didTapButton() {
        guard let buttonTapAction = buttonHandler else { return }
        buttonTapAction()
    }
    
}
