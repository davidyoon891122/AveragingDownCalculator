//
//  MainTabBarController.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/7/24.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
        self.setupViews()
        view.backgroundColor = .systemBackground
    }
    
}

private extension MainTabBarController {
    
    func setupViews() {
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
        
        TabControl.allCases.forEach {
            UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: $0.color], for: $0.state)
        }
        
        let types: [TabType] = TabType.allCases
        
        self.tabBar.items?.enumerated().forEach { index, item in
            let type = types[index]
            
            let image = type.tabbarImage.default
            let selectedImage = type.tabbarImage.selected
            item.image = image.withRenderingMode(.alwaysOriginal)
            item.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
            item.title = type.title
        }
        
        
    }
    
    func setupTabBar() {
        
        
        let calculatorNavigator = CalculatorNavigator(navigationController: self.navigationController, presentingController: self)
        let calculatorViewModel = CalculatorViewModel(navigator: calculatorNavigator)
        
        let calculatorViewController = CalculatorViewController(viewModel: calculatorViewModel)
        
        calculatorViewController.tabBarItem = UITabBarItem(title: "Calculator", image: UIImage(systemName: "drop"), selectedImage: UIImage(systemName: "drop.fill"))
        
        
        let settingsNavigator = SettingsNavigator(navigationController: self.navigationController, presentingController: self)
        let settingsViewModel = SettingsViewModel(navigator: settingsNavigator)
        
        let settingsViewController = SettingsViewController(viewModel: settingsViewModel)
        
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear.fill"))
        
        
        self.viewControllers = [calculatorViewController, settingsViewController]
        
    }
    
}
