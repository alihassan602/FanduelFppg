//
//  HomePresenter.swift
//  Created by Ali Hassan on 15/12/2018.
//

import Foundation

protocol HomeViewOutput: class { }

protocol HomeInteractorOutput: class { }

class HomePresenter {
    
    private let wireframe: IHomeWireframe
    private let interactor: HomeInteractorInput
    private weak var userInterface: HomeViewInput!
    
    init(wireframe: IHomeWireframe, interactor: HomeInteractorInput, userInterface: HomeViewInput) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.userInterface = userInterface
    }
    
}

// MARK: - HomeViewOutput

extension HomePresenter: HomeViewOutput { }

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput { }
