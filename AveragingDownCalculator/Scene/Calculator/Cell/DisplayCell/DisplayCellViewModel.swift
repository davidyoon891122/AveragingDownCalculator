//
//  DisplayCellViewModel.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/11/24.
//

import Foundation
import RxSwift
import RxCocoa

struct DisplayCellViewModel {
    
    struct Inputs {
        
    }
    
    struct Outputs {
        var items: Driver<CalculatorModel>
    }
    
    let calculatorModelRelay: BehaviorRelay<CalculatorModel>
    
    init(calculatorModelRelay: BehaviorRelay<CalculatorModel>) {
        self.calculatorModelRelay = calculatorModelRelay
    }
    
}

extension DisplayCellViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(calculatorModelRelay.value.averagePrice)
    }
    
    static func == (lhs: DisplayCellViewModel, rhs: DisplayCellViewModel) -> Bool {
        lhs.calculatorModelRelay.value.averagePrice == rhs.calculatorModelRelay.value.averagePrice
    }
    
}

extension DisplayCellViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        
        return .init(items: calculatorModelRelay.asDriver())
    }
    
}
