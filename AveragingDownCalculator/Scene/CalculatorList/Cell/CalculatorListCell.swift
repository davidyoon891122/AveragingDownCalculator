//
//  CalculatorListCell.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/20/24.
//

import UIKit
import SnapKit

final class CalculatorListCell: UICollectionViewCell {
    
    static let identifier = String(describing: CalculatorListCell.self)
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Tesla"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2024.03.14"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var nameLabelView: UIView = {
        let view = UIView()
        
        [
            self.itemNameLabel,
            self.dateLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        self.itemNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.lessThanOrEqualTo(150)
        }
        
        self.dateLabel.snp.makeConstraints {
            $0.top.equalTo(self.itemNameLabel.snp.bottom).offset(16.0)
            $0.leading.equalTo(self.itemNameLabel)
            $0.trailing.equalTo(self.itemNameLabel)
            $0.bottom.equalToSuperview().offset(-16.0)
        }
    
        return view
    }()
    
    private lazy var averagePriceLabel: UILabel = {
        let label = UILabel()
        label.text = "74,000￦"
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .purple
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var contrainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 4
        
        [
            self.nameLabelView,
            self.averagePriceLabel
        ]
            .forEach {
                view.addSubview($0)
            }

        self.nameLabelView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.0)
            $0.width.greaterThanOrEqualTo(100)
            $0.centerY.equalToSuperview()
        }
        
        self.averagePriceLabel.snp.makeConstraints {
            $0.leading.equalTo(self.nameLabelView.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.centerY.equalToSuperview()
        }
        
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CalculatorListCell {
    
    func setupViews() {
        self.contentView.addSubview(self.contrainerView)
        
        self.contrainerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    
}

#Preview {
    CalculatorListCell()
}
