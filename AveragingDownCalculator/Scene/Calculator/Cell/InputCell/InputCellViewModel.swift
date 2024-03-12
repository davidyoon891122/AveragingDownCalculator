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
    
}

extension InputCellViewModel: Hashable { }

extension InputCellViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        
        let events = Signal<Void>.merge(
            inputs.buyingPriceAcquisitionCost
                .map { _ in }
                .asSignal(onErrorSignalWith: .empty()),
            
            inputs.additionalBuyingPriceAcquisitionCost
                .map { _ in }
                .asSignal(onErrorSignalWith: .empty())
        )
        
        return .init(events: events)
    }
    
}
