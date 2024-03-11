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

enum CalculatorSectionType {
    case display
    case input
}


final class CalculatorViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: CalculatorViewModel
    
    private var datasource: UICollectionViewDiffableDataSource<CalculatorSectionType, String>!
    
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
            CalculatorDisplayCell.self,
            forCellWithReuseIdentifier: CalculatorDisplayCell.identifier
        )
        
        collectionView.register(
            InputCell.self,
            forCellWithReuseIdentifier: InputCell.identifier
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
            if sectionIndex == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                return section
            } else if sectionIndex == 1 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(400)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(400)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(230)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        })
        
        return layout
    }
    
    func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            if indexPath.section == 0 {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CalculatorDisplayCell.identifier,
                    for: indexPath
                ) as? CalculatorDisplayCell else { return UICollectionViewCell() }
                
                return cell
            } else if indexPath.section == 1 {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: InputCell.identifier,
                    for: indexPath
                ) as? InputCell else { return UICollectionViewCell() }
                
                return cell
            }
            
            return UICollectionViewCell()
        })
        
        applySnapshot()
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<CalculatorSectionType, String>()
        snapshot.appendSections([.display, .input])
        snapshot.appendItems(["Item"], toSection: .display)
        snapshot.appendItems(["top"], toSection: .input)

        datasource.apply(snapshot, animatingDifferences: true)
    }
    
}


#Preview {
    CalculatorViewController(viewModel: CalculatorViewModel(navigator: CalculatorNavigator(navigationController: nil, presentingController: nil)))
}
