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
        
        let completion: ((MainTabBarController?) -> Void) = { vc in
            if let selectedIndex = tab?.rawValue {
                vc?.selectedIndex = selectedIndex
                vc?.loadChildVC()
            }
        }
        
        let currentRootVC = window?.rootViewController
        let currentMainTabVC = (currentRootVC as? UINavigationController)?.topViewController as? MainTabBarController
        let isMainTabVCNotExist = currentMainTabVC == nil
        
        if isMainTabVCNotExist || trainsition {
            let vc = MainTabBarController(navigator: self)
            let nv = UINavigationController(rootViewController: vc)
            nv.isNavigationBarHidden = true
            
            window?.set(newRootViewController: nv)
        } else {
            if currentMainTabVC?.presentedViewController != nil {
                currentMainTabVC?.dismiss(animated: true, completion: {
                    completion(currentMainTabVC)
                })
            } else {
                completion(currentMainTabVC)
            }
        }
        
    }
    
}


