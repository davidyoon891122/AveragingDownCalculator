//
//  CalculatorTitleCell.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/8/24.
//

import UIKit
import SnapKit

final class CalculatorTitleCell: UICollectionViewCell {
    
    static let identifier: String = String(describing:CalculatorTitleCell.self)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Options"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        
        return label
    }()
    
    private lazy var segmentView: UISegmentedControl = {
        let segmentView = UISegmentedControl(items: ["Default", "Floating"])
        segmentView.selectedSegmentIndex = 0
        
        return segmentView
    }()
    
    private lazy var containView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .red
        
        [
            titleLabel,
            segmentView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.bottom.equalToSuperview().offset(-16.0)
        }
        
        segmentView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
        }
        
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CalculatorTitleCell {
    
    func setupCell() {
        self.contentView.addSubview(containView)
        
        containView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(100)
            
        }
    }
    
}

#Preview {
    CalculatorTitleCell()
}
