//
//  HomePresenter.swift
//  Created by Ali Hassan on 15/12/2018.
//

import Foundation

protocol HomeViewOutput: class {
    func viewDidLoad()
    func didTapRetry()
    func didTapPlayer1()
    func didTapPlayer2()
    func didTapNextButton()
    func didTapNewGameButton()
}

protocol HomeInteractorOutput: class {
    func playerLoadSuccess(players: [Player])
    func playerLoadFailed()
}

struct PlayerViewModel {
    let id: String
    let name: String
    let imageURL: URL
    let fppg: Double
}

class HomePresenter {
    
    private let wireframe: IHomeWireframe
    private let interactor: HomeInteractorInput
    private weak var userInterface: HomeViewInput!
    private var game: IPlayerGame?
    
    init(wireframe: IHomeWireframe, interactor: HomeInteractorInput, userInterface: HomeViewInput) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.userInterface = userInterface
    }
    
    private func setNewPlayers() {
        userInterface.showPlayerViews()
        guard let game = game else { return }
        
        let players = game.getNextPlayers(count: 2)
        guard players.count == 2 else { return }
        userInterface.setPlayers(player1: players[0], player2: players[1])
        userInterface.setCounter("Score: \(game.currentScore())")
        userInterface.enablelayerSelection(true)
        userInterface.showNextButton(false)
        userInterface.resetState()
    }
    
    private func selectedPlayer(_ player: Int) {
        guard let game = game else { return }
        userInterface.showFppg()
        userInterface.enablelayerSelection(false)
        
        let correctGuess = game.playerGuessed(playerPosition: player)
        if correctGuess {
            userInterface.showCorrectGuess()
        } else {
            userInterface.showIncorrectGuess()
        }
        
        if game.hasNextRound() {
            userInterface.showNextButton(true)
        } else {
            userInterface.showNextButton(false)
            userInterface.showNewGameButton(true)
            userInterface.setCounter("WIN")
        }
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
        userInterface.showErrorView(false)
        userInterface.showLoadingView(true)
    }
    
    func didTapPlayer1() {
        selectedPlayer(1)
    }
    
    func didTapPlayer2() {
        selectedPlayer(2)
    }
    
    func didTapNextButton() {
        setNewPlayers()
    }
    
    func didTapNewGameButton() {
        guard let game = game else { return }
        game.resetGame()
        setNewPlayers()
        userInterface.showNewGameButton(false)
    }
    
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {
    
    func playerLoadSuccess(players: [Player]) {
        game = PlayerGame(players: players)
        userInterface.showLoadingView(false)
        setNewPlayers()
    }
    
    func playerLoadFailed() {
        userInterface.showLoadingView(false)
        userInterface.showErrorView(true)
    }
    
}
