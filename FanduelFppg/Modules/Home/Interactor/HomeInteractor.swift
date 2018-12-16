//
//  HomeInteractor.swift
//  Created by Ali Hassan on 15/12/2018.
//

import Foundation

protocol HomeInteractorInput: class { }

class HomeInteractor {
    
    weak var presenter: HomeInteractorOutput!
    
}

extension HomeInteractor: HomeInteractorInput { }
