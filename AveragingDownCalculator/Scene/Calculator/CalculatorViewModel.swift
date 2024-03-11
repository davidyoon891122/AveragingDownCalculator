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
        let viewWillAppear: Signal<Bool>
    }
    
    struct Outputs {
        let events: Signal<Void>
    }
    
    private let navigator: CalculatorNavigatorProtocol
    
    private let displayCellViewModel: DisplayCellViewModel = DisplayCellViewModel()
    private let inputCellViewModel: InputCellViewModel = InputCellViewModel()
    
    init(navigator: CalculatorNavigatorProtocol) {
        self.navigator = navigator
    }
    
    func getDisplayCellViewModel() -> DisplayCellViewModel {
        self.displayCellViewModel
    }
    
    func getInputCellViewModel() -> InputCellViewModel {
        self.inputCellViewModel
    }
    
    
}

private extension CalculatorViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        let navigator = self.navigator
        
        let events = Signal<Void>.merge(
            inputs.viewWillAppear
                .do(onNext: {
                    print("viewWillAppear: \($0)")
                })
                .map { _ in }
            )
        
        return .init(events: events)
    }
    
}
