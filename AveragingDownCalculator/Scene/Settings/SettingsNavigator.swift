//
//  SettingsNavigator.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/7/24.
//

import UIKit

protocol SettingsNavigatorProtocol {
    
}

struct SettingsNavigator {
    
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

extension SettingsNavigator: SettingsNavigatorProtocol {
    
}
