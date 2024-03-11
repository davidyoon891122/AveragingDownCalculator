//
//  PreviewTools.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/11/24.
//

import Foundation

struct PreviewTools {
    
    static var isPreview: Bool {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return true
        } else {
            return false
        }
    }
    
}
