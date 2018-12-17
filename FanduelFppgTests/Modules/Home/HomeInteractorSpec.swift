//
//  HomeInteractorSpec.swift
//  Copyright © 2018 Ali Hassan. All rights reserved.
//

import Quick
import Nimble

@testable import FanduelFppg

class HomeInteractorSpec: QuickSpec {
    
    private var components: TestComponents!
    
    override func spec() {
        
        beforeEach {
            self.components = self.makeTestComponents()
        }
        
        describe("the home interactor") {
            context("on being asked for players") {
                it("should notify the presenter when players are received") {
                    self.components.webService.requestShouldSucceed = true
                    self.components.interactor.requestPlayers()
                    expect(self.components.presenter.receivedPlayers).toEventually(beTrue())
                }
            }
            
            context("on being asked for players") {
                it("should notify the presenter appropriately if the player request has failed") {
                    self.components.webService.requestShouldSucceed = false
                    self.components.interactor.requestPlayers()
                    expect(self.components.presenter.playerRequestFailed).toEventually(beTrue())
                }
            }
            
            context("on being asked for players") {
                it("should notify the presenter appropriately if the player request has failed") {
                    self.components.webService.requestShouldSucceed = false
                    self.components.interactor.requestPlayers()
                    expect(self.components.presenter.playerRequestFailed).toEventually(beTrue())
                }
            }
            
        }
        
    }
    
    private func makeTestComponents() -> TestComponents {
        let presenter = MockHomePresenter()
        let webService = MockPlayerWebService()
        let interactor = HomeInteractor(playerWebService: webService)
        interactor.presenter = presenter
        
        return TestComponents(presenter: presenter, interactor: interactor, webService: webService)
    }
    
}

private class MockPlayerWebService: IPlayerssWebService {
    
    private let error: NSError = NSError(domain: "Testing", code: 99, userInfo: nil)
    var requestShouldSucceed: Bool = true
    
    func requestPlayers(success: @escaping ([Player]) -> Void, failure: @escaping (Error) -> Void) {
        if requestShouldSucceed {
            success([])
        } else {
            failure(error)
        }
    }
    
}


private struct TestComponents {
    
    let presenter: MockHomePresenter
    let interactor: HomeInteractor
    let webService: MockPlayerWebService
}

private class MockHomePresenter: HomeViewOutput, HomeInteractorOutput {
    
    private(set) var didLoad: Bool = false
    private(set) var tappedRetry: Bool = false
    private(set) var tappedPlayer1: Bool = false
    private(set) var tappedPlayer2: Bool = false
    private(set) var tappedNextButton: Bool = false
    private(set) var tappedNewGameButton: Bool = false
    private(set) var receivedPlayers: Bool = false
    private(set) var playerRequestFailed: Bool = false
    
    func viewDidLoad() {
        didLoad = true
    }
    
    func didTapRetry() {
        tappedRetry = true
    }
    
    func didTapPlayer1() {
        tappedPlayer1 = true
    }
    
    func didTapPlayer2() {
        tappedPlayer2 = true
    }
    
    func didTapNextButton() {
        tappedNextButton = true
    }
    
    func didTapNewGameButton() {
        tappedNewGameButton = true
    }
    
    func playerLoadSuccess(players: [Player]) {
        receivedPlayers = true
    }
    
    func playerLoadFailed() {
        playerRequestFailed = true
    }
    
}
