//
//  InputCellViewModel.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/11/24.
//

import Foundation
import RxSwift
import RxCocoa

struct InputCellViewModel {
    
    struct Inputs {
        var buyingPriceAcquisitionCost: Driver<(Double, Double)>
        var additionalBuyingPriceAcquisitionCost: Driver<(Double, Double)>
    }
    
    struct Outputs {
        let events: Signal<Void>
    }
    
    let calculatorModelRelay: BehaviorRelay<CalculatorModel>
    
    init(calculatorModelRelay: BehaviorRelay<CalculatorModel>) {
        self.calculatorModelRelay = calculatorModelRelay
    }
    
}

extension InputCellViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(calculatorModelRelay.value.averagePrice)
    }
    
    static func == (lhs: InputCellViewModel, rhs: InputCellViewModel) -> Bool {
        lhs.calculatorModelRelay.value.averagePrice == rhs.calculatorModelRelay.value.averagePrice
    }
    
}

extension InputCellViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        
        let events = Signal<Void>.merge(
            inputs.buyingPriceAcquisitionCost
                .map { _ in }
                .asSignal(onErrorSignalWith: .empty()),
            
            inputs.additionalBuyingPriceAcquisitionCost
                .map { _ in }
                .asSignal(onErrorSignalWith: .empty()),
            Observable.combineLatest(inputs.buyingPriceAcquisitionCost.asObservable(), inputs.additionalBuyingPriceAcquisitionCost.asObservable())
                .map { buyingPrice, additionalPrice in
                    
                    let totalPrice = buyingPrice.0 * buyingPrice.1 + additionalPrice.0 * additionalPrice.1
                    let totalAmount = buyingPrice.1 + additionalPrice.1
                    
                    let calculatorModel = CalculatorModel(averagePrice: totalPrice / totalAmount, totalPrice: totalPrice, totalAmount: totalAmount)
                    calculatorModelRelay.accept(calculatorModel)
                }
                .asSignal(onErrorSignalWith: .empty())
        )
        
        return .init(events: events)
    }
    
}
