//
//  Extension+UIWindow.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/7/24.
//

import UIKit

extension UIWindow {
    
    static var appWindow: UIWindow? {
        return (UIApplication.shared.delegate as? SceneDelegate)?.window
    }
    
}

