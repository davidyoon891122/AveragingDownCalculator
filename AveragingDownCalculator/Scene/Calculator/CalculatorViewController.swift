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

enum CalculatorSectionType: CaseIterable {
    case display
    case input
}

enum CalculatorItem: Hashable {
    case display(DisplayCellViewModel)
    case input(InputCellViewModel)
}

struct CalculatorDataItem {
    
    let section: CalculatorSectionType
    let items: [CalculatorItem]
    
}


final class CalculatorViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: CalculatorViewModel
    
    private var datasource: UICollectionViewDiffableDataSource<CalculatorSectionType, CalculatorItem>!
    
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        bindViewModel()
    }
    
}

private extension CalculatorViewController {
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Calculator"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hey", style: .plain, target: self, action: #selector(didTapDetailViewButton))
        
        
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
        let viewWillAppear = rx.viewWillAppear
            .asSignal(onErrorSignalWith: .empty())
            .map { _ in }
        
        let outputs = self.viewModel.bind(.init(viewWillAppear: viewWillAppear))
        
        self.disposeBag.insert(
            outputs.events.emit(),
            outputs.items.drive(itemBinder)
        )
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
            switch item {
            case .display(let displayViewModel):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CalculatorDisplayCell.identifier,
                    for: indexPath
                ) as? CalculatorDisplayCell else { return UICollectionViewCell() }
                
                cell.set(displayViewModel)
                
                return cell
            case .input(let inputViewModel):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: InputCell.identifier,
                    for: indexPath
                ) as? InputCell else { return UICollectionViewCell() }
                
                cell.set(inputViewModel)
                
                return cell
            }
        })
    
    }
    
    @objc
    func didTapDetailViewButton() {
        viewModel.moveToDetailView()
    }
    
}

private extension CalculatorViewController {
    var itemBinder: Binder<[CalculatorDataItem]> {
        return .init(self) { vc, item in
            var snapshot = NSDiffableDataSourceSnapshot<CalculatorSectionType, CalculatorItem>()
            snapshot.appendSections(CalculatorSectionType.allCases)
            print(item.count)
            item.forEach {
                snapshot.appendItems($0.items, toSection: $0.section)
            }
            
            vc.datasource.apply(snapshot, animatingDifferences: true)
            
        }
    }
}


#Preview {
    CalculatorViewController(viewModel: CalculatorViewModel(navigator: CalculatorNavigator(navigationController: nil, presentingController: nil)))
}
