//
//  HomeWireframe.swift
//  Created by Ali Hassan on 15/12/2018.
//

import Foundation
import UIKit

protocol IHomeWireframe { }

class HomeWireframe: IHomeWireframe {
    
    weak var presenter: HomePresenter!
    weak var viewController: HomeViewController!
    
}
