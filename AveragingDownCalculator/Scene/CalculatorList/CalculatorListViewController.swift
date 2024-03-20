//
//  CalculatorListViewController.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/20/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CalculatorListViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
        collectionView.register(
            CalculatorListCell.self,
            forCellWithReuseIdentifier: CalculatorListCell.identifier
        )
        
        return collectionView
    }()
    
    private lazy var rightBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: nil, action: nil)
        
        return barButton
    }()
    
    private var datasource: UICollectionViewDiffableDataSource<Int, CalculatorListItemModel>!
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: CalculatorListViewModel
    
    init(viewModel: CalculatorListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        self.setupViews()
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureDatasource()
    }
    
}

private extension CalculatorListViewController {
    
    func bindViewModel() {
        let rightBarButtonTapped = rightBarButton.rx.tap
            .throttle()
            .asSignal(onErrorSignalWith: .empty())
        
        let outputs = self.viewModel.bind(.init(rightBarButtonTapped: rightBarButtonTapped))
        
        self.disposeBag.insert(
            outputs.events.emit()
        )
        
    }
    
    func setupNavigation() {
        self.navigationItem.title = "ListView"
        self.navigationItem.rightBarButtonItem = self.rightBarButton
    }
    
    func setupViews() {
        self.view.backgroundColor = .systemBackground
        
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
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100)))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            
            return section
        })
        
        return layout
    }
    
    func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalculatorListCell.identifier, for: indexPath) as? CalculatorListCell else { return UICollectionViewCell() }
            
            return cell
        })
        
        applySnapshot()
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CalculatorListItemModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(CalculatorListItemModel.items)
        
        datasource.apply(snapshot, animatingDifferences: true)
    }
    
}

#Preview {
    CalculatorListViewController(viewModel: CalculatorListViewModel(navigator: CalculatorListNavigator(navigationController: nil, presentingController: nil)))
}
