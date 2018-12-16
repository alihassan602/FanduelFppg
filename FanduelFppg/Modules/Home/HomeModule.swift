//
//  HomeModuleBuilder.swift
//  Created by Ali Hassan on 15/12/2018.
//

import Foundation
import UIKit

struct HomeModule {

    let viewController: HomeViewController
    let wireframe: HomeWireframe
    
    static func build() -> HomeModule {
        let viewController = HomeViewController(nibName: nil, bundle: nil)
        let wireframe = HomeWireframe()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(wireframe: wireframe,
                                            interactor: interactor,
                                            userInterface: viewController)
        
        wireframe.presenter = presenter
        wireframe.viewController = viewController
        
        interactor.presenter = presenter
        
        viewController.eventHandler = presenter
        
        return HomeModule(viewController: viewController, wireframe: wireframe)
    }
    
}
