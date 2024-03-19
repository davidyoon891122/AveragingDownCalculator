//
//  CalculatorDetailViewController.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/8/24.
//

import UIKit

final class CalculatorDetailViewController: UIViewController {
    
    private let viewModel: CalculatorViewModel
    
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

private extension CalculatorDetailViewController {
    
    func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "CalculatorDetail"
    }
    
}
