//
//  PlayerGame.swift
//  Created by Ali Hassan on 16/12/2018.
//

import Foundation

protocol IPlayerGame {
    func setupWithPlayers(_ players: [Player])
}


class PlayerGame: IPlayerGame {
    
    var players: [Player] = []
    
    func setupWithPlayers(_ players: [Player]) {
        self.players = players
    }
    
}
