//
//  PlayerGame.swift
//  Created by Ali Hassan on 16/12/2018.
//

import Foundation

protocol IPlayerGame {
    func getNextPlayers(count: Int) -> [PlayerViewModel]
    func hasNextRound() -> Bool
    func currentScore() -> Int
    func playerGuessed(playerPosition: Int) -> Bool
    func resetGame()
}

class PlayerGame: IPlayerGame {
    
    private var score = 0
    private let players: [PlayerViewModel]
    private var currentPlayers: [PlayerViewModel] = []
    
    init(players: [Player]) {
        let list = players.filter{
            $0.fppg != nil
        }
        
        self.players = list.map {
            PlayerViewModel(id: $0.id, name: "\($0.firstName) \($0.lastName)", imageURL: $0.playerImage.image.url, fppg: $0.fppg ?? 0)
        }
    }
    
    func getNextPlayers(count: Int) -> [PlayerViewModel] {
        currentPlayers = []
        for _ in 1...count {
            currentPlayers.append(getRandomPlayer())
        }
        return currentPlayers
    }
    
    func hasNextRound() -> Bool {
        return score != 10
    }
    
    func currentScore() -> Int {
        return score
    }
    
    func playerGuessed(playerPosition: Int) -> Bool {
        let selectedFPPG = currentPlayers[playerPosition - 1].fppg
        let sortedPlayers = currentPlayers.sorted(by: { $0.fppg > $1.fppg })
        let correct = selectedFPPG >= sortedPlayers.first?.fppg ?? 0
        if correct {
            score += 1
        }
        return correct
    }
    
    func resetGame() {
        score = 0
        currentPlayers = []
    }
    
    private func getRandomPlayer() -> PlayerViewModel {
        return players[Int.random(in: 0 ..< players.count)]
    }
    
}
