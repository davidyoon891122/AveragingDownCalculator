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
        let barButtonItemTapped: Signal<Void>
    }
    
    struct Outputs {
        let events: Signal<Void>
        let items: Driver<[CalculatorDataItem]>
    }
    
    private let navigator: CalculatorNavigatorProtocol
    private let calculatorModel: CalculatorModel
    
    init(
        navigator: CalculatorNavigatorProtocol,
        calculatorModel: CalculatorModel = .init(averagePrice: 0.0, totalPrice: 0.0, totalAmount: 0.0)
    ) {
        self.navigator = navigator
        self.calculatorModel = calculatorModel
    }
    
}

extension CalculatorViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        let navigator = self.navigator
        
        let calculatorModel: CalculatorModel = calculatorModel
        
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
                .map { _ in },
            inputs.barButtonItemTapped
                .do(onNext: {
                    print("Save: \(itemRelay.value)")
                })
                .map { _ in }
            )
        
        
        return .init(events: events, items: items.asDriver(onErrorDriveWith: .empty()))
    }
    
    func moveToDetailView() {
        let navigator = self.navigator
        
        navigator.toDetailView()
    }
    
}
