//
//  CalculatorNavigator.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/7/24.
//

import UIKit

protocol CalculatorNavigatorProtocol {
    
    func toCalculator()
    func toSettings()
    func toDetailView()
    
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
    
    func toSettings() {
        guard let tabViewController = self.presentingController as? UITabBarController else { return }
        tabViewController.selectedIndex = 1
    }
    
    func toDetailView() {
        
        let calculatorViewModel = CalculatorViewModel(navigator: self)
        let calculatorDetailViewController = CalculatorDetailViewController(viewModel: calculatorViewModel)
        
        self.navigationController?.pushViewController(calculatorDetailViewController, animated: true)
        
    }
    
}
