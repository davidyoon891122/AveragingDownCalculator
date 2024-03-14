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
        let items: Driver<[CalculatorDataItem]>
    }
    
    private let navigator: CalculatorNavigatorProtocol
    
    init(navigator: CalculatorNavigatorProtocol) {
        self.navigator = navigator
    }
    
}

extension CalculatorViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        let navigator = self.navigator
        
        let calculatorModel: CalculatorModel = .init(averagePrice: 0, totalPrice: 0, totalAmount: 0)
        
        let itemRelay: BehaviorRelay<CalculatorModel> = .init(value: calculatorModel)
        
        let items: BehaviorRelay<[CalculatorDataItem]> = .init(value: [
            .init(section: .display, items: [.display(.init(calculatorModelRelay: itemRelay))]),
            .init(section: .input, items: [.input(.init(calculatorModelRelay: itemRelay))])
        ])
        
        let events = Signal<Void>.merge(
            inputs.viewWillAppear
                .do(onNext: { _ in
                    print("viewWillAppear")
                })
                .map { _ in }
            )
        
        
        return .init(events: events, items: items.asDriver(onErrorDriveWith: .empty()))
    }
    
}
