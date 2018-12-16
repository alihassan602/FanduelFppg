//
//  HomeViewController.swift
//  Created by Ali Hassan on 15/12/2018.
//

import Foundation
import UIKit

protocol HomeViewInput: class {
    func showLoadingView(_ show: Bool)
    func showErrorView(_ show: Bool)
    func showPlayerViews()
    func setPlayers(player1: PlayerViewModel, player2: PlayerViewModel)
    func showFppg()
    func showNextButton(_ show: Bool)
    func showNewGameButton(_ show: Bool)
    func showCorrectGuess()
    func showIncorrectGuess()
    func resetState()
    func setCounter(_ text: String)
    func enablelayerSelection(_ enable: Bool)
}

class HomeViewController: UIViewController {
    
    private lazy var player1View: PlayerViewControl = {
        let temp = PlayerViewControl()
        temp.isHidden = true
        temp.addTarget(self, action: #selector(didTapPlayer1), for: .touchUpInside)
        return temp
    }()
    
    private let player2View: PlayerViewControl = {
        let temp = PlayerViewControl()
        temp.isHidden = true
        temp.addTarget(self, action: #selector(didTapPlayer2), for: .touchUpInside)
        return temp
    }()
    
    private let loadingView: LoadingView = {
        let temp = LoadingView()
        temp.isHidden = true
        return temp
    }()
    
    private lazy var errorView: ErrorView = {
        let temp = ErrorView()
        temp.isHidden = true
        temp.buttonHandler = didTapRetry
        return temp
    }()
    
    private lazy var nextButton: UIButton = {
        let temp = UIButton()
        temp.isHidden = true
        temp.setTitle("Next", for: .normal)
        temp.setTitleColor(.blue, for: .normal)
        temp.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return temp
    }()
    
    private lazy var newGameButton: UIButton = {
        let temp = UIButton()
        temp.isHidden = true
        temp.setTitle("New Game", for: .normal)
        temp.setTitleColor(.blue, for: .normal)
        temp.addTarget(self, action: #selector(didTapNewGameButton), for: .touchUpInside)
        return temp
    }()
    
    var eventHandler: HomeViewOutput!
    
    override func loadView() {
        super.loadView()
        title = "FPPG"
        
        view.addSubview(loadingView)
        loadingView.edgesToSuperview()
        
        view.addSubview(errorView)
        errorView.edgesToSuperview()
        
        view.addSubview(player1View)
        player1View.isHidden = true
        view.addSubview(player2View)
        player2View.isHidden = true
        
        let views = [player1View, player2View]
        view.stack(views, axis: .horizontal, width: (UIScreen.main.bounds.width / 2) - 10, spacing: 10)
        
        
        view.addSubview(nextButton)
        nextButton.topToBottom(of: player1View, offset: 16)
        nextButton.centerXToSuperview()
        
        view.addSubview(newGameButton)
        newGameButton.topToBottom(of: player1View, offset: 16)
        newGameButton.centerXToSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler.viewDidLoad()
    }
    
    private func didTapRetry() {
        eventHandler.didTapRetry()
    }
    
    @objc private func didTapPlayer1() {
        eventHandler.didTapPlayer1()
    }
    
    @objc private func didTapPlayer2() {
        eventHandler.didTapPlayer2()
    }
    
    @objc private func didTapNextButton() {
        eventHandler.didTapNextButton()
    }
    
    @objc private func didTapNewGameButton() {
        eventHandler.didTapNewGameButton()
    }
    
}

extension HomeViewController: HomeViewInput {
    
    func setPlayers(player1: PlayerViewModel, player2: PlayerViewModel) {
        player1View.setPlayer(player1)
        player2View.setPlayer(player2)
    }
    
    func showLoadingView(_ show: Bool) {
        loadingView.isHidden = !show
    }
    
    func showErrorView(_ show: Bool) {
        errorView.isHidden = !show
    }
    
    func showPlayerViews() {
        player1View.isHidden = false
        player2View.isHidden = false
    }
    
    func showFppg() {
        player1View.showFppg()
        player2View.showFppg()
    }
    
    func showNextButton(_ show: Bool) {
        nextButton.isHidden = !show
    }
    
    func showNewGameButton(_ show: Bool) {
        newGameButton.isHidden = !show
    }
    
    func showCorrectGuess() {
        view.backgroundColor = .green
    }
    
    func showIncorrectGuess() {
        view.backgroundColor = .red
    }
    
    func resetState() {
        view.backgroundColor = .white
    }
    
    func setCounter(_ text: String) {
        title = text
    }
    
    func enablelayerSelection(_ enable: Bool) {
        player1View.isEnabled = enable
        player2View.isEnabled = enable
    }
    
}
