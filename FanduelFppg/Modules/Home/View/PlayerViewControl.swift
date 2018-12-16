//
//  PlayerViewControl.swift
//  Created by Ali Hassan on 16/12/2018.
//

import Foundation
import UIKit
import TinyConstraints
import Nuke

class PlayerViewControl: UIControl {
    
    private lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(named: "placeholder")
        temp.contentMode = .scaleAspectFit
        return temp
    }()
    
    private let playerNameLabel: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        temp.font = Font.seventeenRegular
        temp.textColor = .black
        return temp
    }()
    
    private let playerFppgLabel: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        temp.isHidden = true
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
        addSubview(imageView)
        imageView.topToSuperview(offset: 16, usingSafeArea: true)
        imageView.leftToSuperview()
        imageView.rightToSuperview()
        imageView.height(150)
        
        addSubview(playerNameLabel)
        playerNameLabel.topToBottom(of: imageView, offset: 8)
        playerNameLabel.leftToSuperview()
        playerNameLabel.rightToSuperview()
        playerNameLabel.bottomToSuperview()
        
        addSubview(playerFppgLabel)
        playerFppgLabel.topToBottom(of: imageView, offset: 8)
        playerFppgLabel.leftToSuperview()
        playerFppgLabel.rightToSuperview()
        playerFppgLabel.bottomToSuperview()
    }
    
    func setPlayer(_ player: PlayerViewModel) {
        playerNameLabel.text = player.name
        
        playerFppgLabel.text = String(format: "%.2f", player.fppg)
        playerNameLabel.isHidden = false
        playerFppgLabel.isHidden = true
        Nuke.loadImage(with: player.imageURL, into: imageView)
    }
    
    func showFppg() {
        playerFppgLabel.isHidden = false
        playerNameLabel.isHidden = true
    }
    
}
