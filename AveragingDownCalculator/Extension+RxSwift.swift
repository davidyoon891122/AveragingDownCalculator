//
//  Extension+RxSwift.swift
//  AveragingDownCalculator
//
//  Created by Davidyoon on 3/11/24.
//

import UIKit
import RxSwift
import RxCocoa

private enum Constant {
    static let throttleDueTime: RxTimeInterval = .milliseconds(300)
}

extension ObservableType {
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
    func throttle(_ dueTime: RxTimeInterval = Constant.throttleDueTime) -> Observable<Element> {
        return throttle(dueTime, latest: false, scheduler: MainScheduler.instance)
    }
    
}

extension RxSwift.Reactive where Base: UIViewController {
    
    var viewWillAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { $0.first as? Bool ?? false }
    }
    
    var viewDidAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewDidAppear))
            .map { $0.first as? Bool ?? false }
    }
    
}
