//
//  MainTabBarNavigator.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/7/24.
//

import UIKit

protocol MainTabBarNavigatorProtocol {
    
    func toMainTab(_ tab: TabType?)
    
    
}

struct MainTabBarNavigator {
    
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
}

extension MainTabBarNavigator: MainTabBarNavigatorProtocol {
    
    func toMainTab(_ tab: TabType?) {
        self.toMainTab(tab, trainsition: false)
    }
    
}

private extension MainTabBarNavigator {
    
    func toMainTab(_ tab: TabType?, trainsition: Bool) {
        let window = self.window ?? UIWindow.appWindow
        
        let currentRootVC = window?.rootViewController
        let currentMainTabVC = (currentRootVC as? UINavigationController)?.topViewController as? MainTabBarController
        let isMainTabVCNotExit = currentMainTabVC == nil
        
        if isMainTabVCNotExit || trainsition {
            let vc = MainTabBarController()
            
        }
        
    }
    
}


