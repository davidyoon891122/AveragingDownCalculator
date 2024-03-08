//
//  CalculatorViewController.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/7/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Combine


final class CalculatorViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: CalculatorViewModel
    
    private var datasource: UICollectionViewDiffableDataSource<Int, String>!
    
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.bindViewModel()
        
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            CalculatorTitleCell.self,
            forCellWithReuseIdentifier: CalculatorTitleCell.identifier
        )
        
        return collectionView
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureDatasource()
    }
    
}

private extension CalculatorViewController {
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Calculator"
        
        
        [
            self.collectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func bindViewModel() {
       
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        })
        
        return layout
    }
    
    func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            if indexPath.section == 0 {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CalculatorTitleCell.identifier,
                    for: indexPath
                ) as? CalculatorTitleCell else { return UICollectionViewCell() }
                
                return cell
            }
            
            return UICollectionViewCell()
        })
        
        applySnapshot()
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(["Item"])
        
        datasource.apply(snapshot, animatingDifferences: true)
    }
    
}


#Preview {
    CalculatorViewController(viewModel: CalculatorViewModel(navigator: CalculatorNavigator(navigationController: nil, presentingController: nil)))
}
