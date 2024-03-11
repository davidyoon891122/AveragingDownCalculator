//
//  InputCell.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/11/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class InputCell: UICollectionViewCell {
    
    static let identifier: String = String(describing:InputCell.self)
    
    private lazy var currentLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Current Asset"
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var buyingPriceTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Buying Price"
        textField.padding = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        
        return textField
    }()
    
    private lazy var buyingAmountTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Buying Amount"
        textField.padding = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        
        return textField
    }()
    
    private lazy var acquisitionCostLabel: UILabel = {
        let label = UILabel()
        label.text = "Acquisition Cost: 0￦"
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var additionalBuyingLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Additional Buying Asset"
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var additionalBuyingPriceTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Additional Buying Price"
        textField.padding = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        
        return textField
    }()
    
    private lazy var additionalBuyingAmountTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Additional Buying Amount"
        textField.padding = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        
        return textField
    }()
    
    private lazy var additionalAcquisitionCostLabel: UILabel = {
        let label = UILabel()
        label.text = "Additional Acquisition Cost: 0￦"
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    private let separatorView = SeparatorView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        [
            self.currentLabel,
            self.buyingPriceTextField,
            self.buyingAmountTextField,
            self.acquisitionCostLabel,
            self.additionalBuyingLabel,
            self.additionalBuyingPriceTextField,
            self.additionalBuyingAmountTextField,
            self.additionalAcquisitionCostLabel,
            self.separatorView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        self.currentLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        self.buyingPriceTextField.snp.makeConstraints {
            $0.top.equalTo(self.currentLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        self.buyingAmountTextField.snp.makeConstraints {
            $0.top.equalTo(self.buyingPriceTextField.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        self.acquisitionCostLabel.snp.makeConstraints {
            $0.top.equalTo(buyingAmountTextField.snp.bottom).offset(16.0)
            $0.leading.equalTo(self.buyingAmountTextField)
            $0.trailing.equalTo(self.buyingAmountTextField)
        }
        
        self.additionalBuyingLabel.snp.makeConstraints {
            $0.top.equalTo(acquisitionCostLabel.snp.bottom).offset(32.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        self.additionalBuyingPriceTextField.snp.makeConstraints {
            $0.top.equalTo(self.additionalBuyingLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        self.additionalBuyingAmountTextField.snp.makeConstraints {
            $0.top.equalTo(self.additionalBuyingPriceTextField.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        self.additionalAcquisitionCostLabel.snp.makeConstraints {
            $0.top.equalTo(self.additionalBuyingAmountTextField.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16.0)
        }
        
        self.separatorView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    var buyingPriceTextFieldEvent: ControlProperty<String?> {
        self.buyingPriceTextField.rx.text
    }
    
    var buyingAmountTextFieldEvent: ControlProperty<String?> {
        self.buyingAmountTextField.rx.text
    }
    
    var additionalPriceTextFieldEvent: ControlProperty<String?> {
        self.additionalBuyingPriceTextField.rx.text
    }
    
    var additionalAmountTextFieldEvent: ControlProperty<String?> {
        self.additionalBuyingAmountTextField.rx.text
    }
    
}

private extension InputCell {
    
    func setupViews() {
        self.contentView.addSubview(containerView)
        
        self.containerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.centerY.equalToSuperview()
        }
        
    }
    
}

#Preview {
    
    InputCell()
    
}

