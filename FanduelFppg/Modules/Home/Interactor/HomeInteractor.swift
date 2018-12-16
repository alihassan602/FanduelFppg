//
//  HomeInteractor.swift
//  Created by Ali Hassan on 15/12/2018.
//

import Foundation

protocol HomeInteractorInput: class {
    func requestPlayers()
}

class HomeInteractor {
    
    weak var presenter: HomeInteractorOutput!
    private let playerWebService: IPlayerssWebService
    
    init(playerWebService: IPlayerssWebService) {
        self.playerWebService = playerWebService
    }
    
}

extension HomeInteractor: HomeInteractorInput {
    
    func requestPlayers() {
        playerWebService.requestPlayers(success: { [weak self] (players) in
            self?.presenter.playerLoadSuccess(players: players)
            }, failure: { (error) in
                self.presenter.playerLoadFailed()
        })
    }
}
