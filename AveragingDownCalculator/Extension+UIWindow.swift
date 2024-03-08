//
//  Extension+UIWindow.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/7/24.
//

import UIKit

extension UIWindow {
    
    func set(newRootViewController: UIViewController) {
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        layer.add(transition, forKey: kCATransition)
        
        let oldRootController = self.rootViewController
        
        oldRootController?.dismiss(animated: false) {
            oldRootController?.view.removeFromSuperview()
        }
    }
    
    static var appWindow: UIWindow? {
        return (UIApplication.shared.delegate as? SceneDelegate)?.window
    }
    
}

