//
//  CalculatorListViewModel.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/20/24.
//

import Foundation
import RxSwift
import RxCocoa

struct CalculatorListViewModel {
    
    struct Inputs {
        var rightBarButtonTapped: Signal<Void>
    }
    
    struct Outputs {
        var events: Signal<Void>
    }
    
    private let navigator: CalculatorListNavigatorProtocol
    
    init(navigator: CalculatorListNavigatorProtocol) {
        self.navigator = navigator
    }
    
}

extension CalculatorListViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        let navigator = navigator
        
        let events = Signal<Void>.merge(
            inputs.rightBarButtonTapped
                .do(onNext: { _ in
                    navigator.toCalculator()
                })
                .map { _ in }
        )
        
        
        
        return .init(events: events)
    }
    
}
