//
//  CalculatorDisplayCell.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/11/24.
//

import UIKit
import SnapKit

final class CalculatorDisplayCell: UICollectionViewCell {
    
    static let identifier: String = String(describing:CalculatorDisplayCell.self)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Average Price"
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var averagePriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 36)
        label.text = "0 ￦"
        label.textColor = .label
        label.textAlignment = .center
        
        return label
    }()
    
    private let totalPriceView = DisplayTotalTitleValueView(title: "Total Price: ", value: "0 ￦")
    private let totalAmountView = DisplayTotalTitleValueView(title: "Total Amount: ", value: "0")
    
    private lazy var totalHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        [
            self.totalPriceView,
            self.totalAmountView
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private let separatorView = SeparatorView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        [
            self.titleLabel,
            self.averagePriceLabel,
            self.totalHStackView,
            self.separatorView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        self.titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        self.averagePriceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(48.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
        }
        
        self.totalHStackView.snp.makeConstraints {
            $0.top.equalTo(averagePriceLabel.snp.bottom).offset(48.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-16.0)
        }
        
        self.separatorView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CalculatorDisplayCell {
    
    func set(_ viewModel: DisplayCellViewModel) {
        
    }
    
}

private extension CalculatorDisplayCell {
    
    func setupViews() {
        contentView.addSubview(containerView)
        
        if PreviewTools.isPreview {
            containerView.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(16.0)
                $0.trailing.equalToSuperview().offset(-16)
                $0.centerY.equalToSuperview()
                $0.height.equalTo(230)
            }
        }
        
        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(230)
        }
        
    }
    
}

#Preview {
    CalculatorDisplayCell()
}
