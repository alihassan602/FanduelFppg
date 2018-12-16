//
//  HomeViewController.swift
//  Created by Ali Hassan on 15/12/2018.
//

import Foundation
import UIKit

protocol HomeViewInput: class {
    func showLoadingView(_ show: Bool)
    func showErrorView(_ show: Bool)
}

class HomeViewController: UIViewController {
    
    var eventHandler: HomeViewOutput!
    
    private let loadingView: LoadingView = {
        let temp = LoadingView()
        temp.isHidden = true
        return temp
    }()
    
    private lazy var errorView: ErrorView = {
        let temp = ErrorView()
        temp.isHidden = true
        temp.buttonHandler = didTapRetry
        return temp
    }()
    
    override func loadView() {
        super.loadView()
        
        title = "FPPG"
        
        view.addSubview(loadingView)
        loadingView.edgesToSuperview()
        
        view.addSubview(errorView)
        errorView.edgesToSuperview()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler.viewDidLoad()
    }
    
    private func didTapRetry() {
        eventHandler.didTapRetry()
    }
    
}

extension HomeViewController: HomeViewInput {
    
    func showLoadingView(_ show: Bool) {
        loadingView.isHidden = !show
    }
    
    func showErrorView(_ show: Bool) {
        errorView.isHidden = !show
    }
    
}
