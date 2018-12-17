//
//  HomePresenterSpec.swift
//  Copyright © 2018 Ali Hassan. All rights reserved.
//

import Quick
import Nimble

@testable import FanduelFppg

class HomePresenterSpec: QuickSpec {
    
    private var components: TestComponents!
    
    override func spec() {
        
        beforeEach {
            self.components = self.makeTestComponents()
        }
        
        let player = Player(firstName: "", lastName: "", fppg: 12.22, id: "", playerImage: Image(image: Default(url: URL(string: "https://via.placeholder.com/150")!)))
        
        describe("the home presenter") {
            context("on being called to fetch data") {
                it("should relay the message to the interactor and show the loading view") {
                    self.components.presenter.viewDidLoad()
                    expect(self.components.interactor.gettingPlayers).to(beTrue())
                    expect(self.components.view.showingLoadingView).to(beTrue())
                    expect(self.components.view.showingErrorView).to(beFalse())
                }
            }
            
            context("on being told players are available") {
                it("should relay the message to the view and hide the loading view") {
                    self.components.presenter.playerLoadSuccess(players: [player])
                    expect(self.components.view.showingErrorView).to(beFalse())
                    expect(self.components.view.showingLoadingView).to(beFalse())
                }
            }
            
            context("on receiving player data") {
                it("should display players and set the score title") {
                    self.components.interactor.requestPlayers()
                    expect(self.components.view.counterTextShown).to(equal("Score: 0"))
                    expect(self.components.view.showingPlayerViews).to(beTrue())
                }
            }
            
            context("on having failed to receive player data") {
                it("should show the view's error state") {
                    self.components.interactor.requestShouldSucceed = false
                    self.components.interactor.requestPlayers()
                    expect(self.components.view.showingErrorView).to(beTrue())
                    expect(self.components.view.showingLoadingView).to(beFalse())
                    expect(self.components.view.showingPlayerViews).to(beFalse())
                }
            }
            
            context("on having selecing a player") {
                it("should show the next button") {
                    self.components.interactor.requestShouldSucceed = true
                    self.components.presenter.viewDidLoad()
                    self.components.presenter.didTapPlayer1()
                    expect(self.components.view.showingNext).to(beTrue())
                }
            }
            
            context("on selecing next") {
                it("should hide the nexxt button and clear answer state") {
                    self.components.interactor.requestShouldSucceed = true
                    self.components.presenter.viewDidLoad()
                    self.components.presenter.didTapPlayer1()
                    expect(self.components.view.showingNext).to(beTrue())
                    self.components.presenter.didTapNextButton()
                    expect(self.components.view.showingNext).to(beFalse())
                    expect(self.components.view.clearedAnswerState).to(beTrue())
                }
            }
            
        }
        
    }
    
    private func makeTestComponents() -> TestComponents {
        let viewController = MockHomeViewController()
        let interactor = MockHomeInteractor()
        let wireframe = MockHomeWireframe()
        let presenter = HomePresenter(wireframe: wireframe, interactor: interactor, userInterface: viewController)
        interactor.presenter = presenter
        
        return TestComponents(view: viewController, interactor: interactor, presenter: presenter, wireframe: wireframe)
    }
    
}

private struct TestComponents {
    
    let view: MockHomeViewController
    let interactor: MockHomeInteractor
    let presenter: HomePresenter
    let wireframe: MockHomeWireframe
}

private class MockHomeViewController: HomeViewInput {
    
    private(set) var showingLoadingView: Bool = false
    private(set) var showingErrorView: Bool = false
    private(set) var showingPlayerViews: Bool = false
    private(set) var setPlayers: Bool = false
    private(set) var showingFppg: Bool = false
    private(set) var showingNext: Bool = false
    private(set) var showedCorrectState: Bool = false
    private(set) var showedIncorrectState: Bool = false
    private(set) var counterTextShown: String = ""
    private(set) var showingNewGameButton: Bool = false
    private(set) var clearedAnswerState: Bool = false
    private(set) var enabledPlayerSelection: Bool = false
    
    func showLoadingView(_ show: Bool) {
        showingLoadingView = show
    }
    
    func showErrorView(_ show: Bool) {
        showingErrorView = show
    }
    
    func showPlayerViews() {
        showingPlayerViews = true
    }
    
    func setPlayers(player1: PlayerViewModel, player2: PlayerViewModel) {
        setPlayers = true
    }
    
    func showFppg() {
        showingFppg = true
    }
    
    func showCorrectGuess() {
        showedCorrectState = true
    }
    
    func showIncorrectGuess() {
        showedIncorrectState = true
    }
    
    func setCounter(_ text: String) {
        counterTextShown = text
    }
    
    func showNextButton(_ show: Bool) {
        showingNext = show
    }
    
    func showNewGameButton(_ show: Bool) {
        showingNewGameButton = show
    }
    
    func resetState() {
        clearedAnswerState = true
    }
    
    func enablelayerSelection(_ enable: Bool) {
        enabledPlayerSelection = enable
    }
    
}

private class MockHomeInteractor: HomeInteractorInput {
    
    weak var presenter: HomeInteractorOutput!
    
    private(set) var gettingPlayers: Bool = false
    var requestShouldSucceed: Bool = true
    let playerList: [Player]
    
    init() {
        let image = Image(image: Default(url: URL(string: "https://via.placeholder.com/150")!))
        let player1 = Player(firstName: "f1", lastName: "l1", fppg: 12, id: "1", playerImage: image)
        let player2 = Player(firstName: "f2", lastName: "l2", fppg: 12, id: "2", playerImage: image)
        let player3 = Player(firstName: "f3", lastName: "l3", fppg: 12, id: "3", playerImage: image)
        let player4 = Player(firstName: "f4", lastName: "l4", fppg: 12, id: "4", playerImage: image)
        let player5 = Player(firstName: "f5", lastName: "l5", fppg: nil, id: "5", playerImage: image)
        
        playerList = [player1, player2, player3, player4, player5]
    }
    
    func requestPlayers() {
        gettingPlayers = true
        if requestShouldSucceed {
            self.presenter.playerLoadSuccess(players: playerList)
        } else {
            self.presenter.playerLoadFailed()
        }
    }
    
}

private class MockHomeWireframe: IHomeWireframe { }
