//
//  MainTabBarItem.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/7/24.
//

import UIKit

enum TabType: Int, CaseIterable {
    
    case calculator
    case settings
    
}

extension TabType {
    
    var title: String {
        switch self {
        case .calculator:
            return "Calculator"
        case .settings:
            return "Settings"
        }
    }
    
    var tabbarImage: (default: UIImage, selected: UIImage) {
        switch self {
        case .calculator:
            return (
                UIImage(systemName: "drop") ?? UIImage(systemName: "house")!,
                UIImage(systemName: "drop.fill") ?? UIImage(systemName: "house")!
            )
        case .settings:
            return (
                UIImage(systemName: "gear.circle") ?? UIImage(systemName: "house")!,
                UIImage(systemName: "gear.circle.fill") ?? UIImage(systemName: "house")!
            )
        }
    }
    
}


enum TabControl: Int, CaseIterable {
    
    case normal
    case selected
    
    var state: UIControl.State {
        switch self {
        case .normal:
            return .normal
        case .selected:
            return .selected
        }
    }
    
    var color: UIColor {
        switch self {
        case .normal:
            return UIColor.gray.withAlphaComponent(0.6)
        case .selected:
            return UIColor.gray
        }
    }
    
}
