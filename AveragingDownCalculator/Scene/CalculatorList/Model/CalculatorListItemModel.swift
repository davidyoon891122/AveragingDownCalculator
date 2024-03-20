//
//  CalculatorListItemModel.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/20/24.
//

import Foundation

struct CalculatorListItemModel: Hashable {
    let id = UUID()
    let name: String
    let date: String
    let price: String
}

extension CalculatorListItemModel {
    
    static let items: [Self] = [
        .init(name: "Tesla", date: "2024.03.10", price: "172$"),
        .init(name: "Tesla", date: "2024.03.10", price: "172$"),
        .init(name: "Tesla", date: "2024.03.10", price: "172$"),
        .init(name: "Tesla", date: "2024.03.10", price: "172$"),
        .init(name: "Tesla", date: "2024.03.10", price: "172$"),
        .init(name: "Tesla", date: "2024.03.10", price: "172$"),
        .init(name: "Tesla", date: "2024.03.10", price: "172$"),
        .init(name: "Tesla", date: "2024.03.10", price: "172$"),
    ]
    
}
