//
//  MainTabBarController.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/7/24.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private var navigator: MainTabBarNavigator
    
    init(navigator: MainTabBarNavigator) {
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
        self.setupViews()
        view.backgroundColor = .systemBackground
    }
    
    func loadChildVC() {
        self.setupTabBar()
    }
    
}

private extension MainTabBarController {
    
    func setupViews() {
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
        
        let calculatorNC = UINavigationController()
        let calculatorNavigator = CalculatorListNavigator(navigationController: calculatorNC, presentingController: self)
        let calculatorListVM = CalculatorListViewModel(navigator: calculatorNavigator)
        
        
        let calculatorListVC = CalculatorListViewController(viewModel: calculatorListVM)
        
        calculatorNC.pushViewController(calculatorListVC, animated: false)
        calculatorNC.tabBarItem = UITabBarItem(title: "Calculator", image: UIImage(systemName: "drop"), selectedImage: UIImage(systemName: "drop.fill"))
        
        
        let settingsNC = UINavigationController()
        let settingsNavigator = SettingsNavigator(navigationController: settingsNC, presentingController: self)
        let settingsViewModel = SettingsViewModel(navigator: settingsNavigator)
        
        let settingsViewController = SettingsViewController(viewModel: settingsViewModel)
        
        settingsNC.pushViewController(settingsViewController, animated: false)
        
        settingsNC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear.fill"))
        
        
        self.viewControllers = [calculatorNC, settingsNC]
        
    }
    
}

#Preview {
    MainTabBarController(navigator: MainTabBarNavigator(window: UIWindow.appWindow))
}
