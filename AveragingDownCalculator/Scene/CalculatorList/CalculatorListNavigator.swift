//
//  CalculatorListNavigation.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/20/24.
//

import UIKit

protocol CalculatorListNavigatorProtocol {
    
    func toCalculator()
    
}

struct CalculatorListNavigator {
    
    private var navigationController: UINavigationController?
    private var presentingController: UIViewController?
    
    init(
        navigationController: UINavigationController?,
        presentingController: UIViewController?
    ) {
        self.navigationController = navigationController
        self.presentingController = presentingController
    }
    
}

extension CalculatorListNavigator: CalculatorListNavigatorProtocol {
    
    func toCalculator() {
        let navigator = CalculatorNavigator(navigationController: self.navigationController, presentingController: nil)
        navigator.toCalculator()
    }
    
}
