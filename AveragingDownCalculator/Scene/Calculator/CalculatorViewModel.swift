//
//  CalculatorViewModel.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/7/24.
//

import Foundation
import RxSwift
import RxCocoa

struct CalculatorViewModel {
    
    struct Inputs {
        let didTapSettingsButton: Signal<Void>
    }
    
    struct Outputs {
        let events: Signal<Void>
    }
    
    private let navigator: CalculatorNavigatorProtocol
    
    init(navigator: CalculatorNavigatorProtocol) {
        self.navigator = navigator
    }
    
}

extension CalculatorViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        let navigator = self.navigator
        
        let events = Signal<Void>.merge(
            inputs.didTapSettingsButton
            .do(onNext: navigator.toSettings)
            )
        
        return .init(events: events)
    }
    
}
