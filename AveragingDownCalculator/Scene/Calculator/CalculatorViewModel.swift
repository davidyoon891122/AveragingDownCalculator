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
        let viewWillAppear: Signal<Void>
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

extension CalculatorViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        let navigator = self.navigator
        
        let events = Signal<Void>.merge(
            inputs.viewWillAppear
                .do(onNext: { _ in
                    print("viewWillAppear")
                })
                .map { _ in }
            )
        
        
        
        return .init(events: events)
    }
    
}
