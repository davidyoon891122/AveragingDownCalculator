//
//  CalculatorNavigator.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/7/24.
//

import UIKit

protocol CalculatorNavigatorProtocol {
    
    func toCalculator()
    
}

struct CalculatorNavigator {
    
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

extension CalculatorNavigator: CalculatorNavigatorProtocol {
    
    func toCalculator() {
        let calculatorViewController = CalculatorViewController(viewModel: CalculatorViewModel(navigator: self))
        self.navigationController?.pushViewController(calculatorViewController, animated: false)
    }
    
}
