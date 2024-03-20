//
//  Extension+Double.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/20/24.
//

import Foundation

extension Double {
    
    func truncateTo(digit: Int) -> String {
        return String(format: "%.\(digit)f", self)
    }
    
}
