//
//  CalculatorDetailNavigator.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/8/24.
//

import UIKit

protocol CalculatorDetailNavigatorProtocol {
 
    func toMain()
    
}

struct CalculatorDetailNavigator {
    
    private var navigationController: UINavigationController?
    private let window: UIWindow?
    
    init(
        navigationController: UINavigationController?,
        window: UIWindow? = UIWindow.appWindow
    ) {
        self.navigationController = navigationController
        self.window = window
    }
    
}

extension CalculatorDetailNavigator: CalculatorDetailNavigatorProtocol {
    
    func toMain() {
        let navigator = MainTabBarNavigator(window: self.window)
        navigator.toMainTab(.settings)
    }
    
    
}
