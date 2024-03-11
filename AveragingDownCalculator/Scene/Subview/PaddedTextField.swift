//
//  PaddedTextField.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/11/24.
//

import UIKit

class PaddedTextField: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
