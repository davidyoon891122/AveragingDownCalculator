//
//  CalculatorViewModel.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/7/24.
//

import Foundation

struct CalculatorViewModel {
    
    struct Inputs {
        
    }
    
    struct Outputs {
        
    }
    
    private let navigator: CalculatorNavigatorProtocol
    
    init(navigator: CalculatorNavigatorProtocol) {
        self.navigator = navigator
    }
    
}

extension CalculatorViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        
        return .init()
    }
    
}
