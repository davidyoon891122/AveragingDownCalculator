//
//  DisplayTotalTitleValueView.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/11/24.
//

import UIKit
import SnapKit

final class DisplayTotalTitleValueView: UIView {
    
    private lazy var totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Price: "
        label.font = .boldSystemFont(ofSize: 10)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var totalValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0 ￦"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .red
        label.textAlignment = .center
        
        return label
    }()
    
    init(title: String, value: String) {
        super.init(frame: .zero)
        self.totalTitleLabel.text = title
        self.totalValueLabel.text = value
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValue(value: String) {
        self.totalValueLabel.text = value
    }
    
}

private extension DisplayTotalTitleValueView {
    
    func setupView() {
        [
            self.totalTitleLabel,
            self.totalValueLabel
        ]
            .forEach {
                self.addSubview($0)
            }
        
        self.totalTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        self.totalTitleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        
        self.totalValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.totalTitleLabel)
            $0.leading.equalTo(self.totalTitleLabel.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().offset(-4)
        }
    }
    
}

#Preview {
    let preview = DisplayTotalTitleValueView(title: "Total Price", value: "100,000,000 ￦")
    preview.layer.borderColor = UIColor.gray.cgColor
    preview.layer.borderWidth = 1
    
    return preview
}


