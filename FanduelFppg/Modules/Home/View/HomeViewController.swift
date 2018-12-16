//
//  HomeViewController.swift
//  Created by Ali Hassan on 15/12/2018.
//

import Foundation
import UIKit

protocol HomeViewInput: class {
    func hideLoadingView()
    func showLoadingView()
    func showNetworkError()
}

class HomeViewController: UIViewController {
    
    var eventHandler: HomeViewOutput!
    
    override func loadView() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension HomeViewController: HomeViewInput {
    
    func hideLoadingView() {
        
    }
    
    func showLoadingView() {
        
    }
    
    func showNetworkError() {
        
    }
}
