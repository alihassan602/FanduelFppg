//
//  HomePresenter.swift
//  Created by Ali Hassan on 15/12/2018.
//

import Foundation

protocol HomeViewOutput: class {
    func viewDidLoad()
    func didTapRetry()
}

protocol HomeInteractorOutput: class {
    func playerLoadSuccess(players: [Player])
    func playerLoadFailed()
}

class HomePresenter {
    
    private let wireframe: IHomeWireframe
    private let interactor: HomeInteractorInput
    private weak var userInterface: HomeViewInput!
    private let playerGame: IPlayerGame
    
    init(wireframe: IHomeWireframe, interactor: HomeInteractorInput, userInterface: HomeViewInput, playerGame: IPlayerGame) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.userInterface = userInterface
        self.playerGame = playerGame
    }
    
}

// MARK: - HomeViewOutput

extension HomePresenter: HomeViewOutput {
    
    func viewDidLoad() {
        interactor.requestPlayers()
        userInterface.showLoadingView(true)
    }
    
    func didTapRetry() {
        interactor.requestPlayers()
        userInterface.showLoadingView(true)
    }
    
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {
    
    func playerLoadSuccess(players: [Player]) {
        playerGame.setupWithPlayers(players)
        userInterface.showLoadingView(false)
    }
    
    func playerLoadFailed() {
        userInterface.showLoadingView(false)
        userInterface.showErrorView(true)
    }
}
