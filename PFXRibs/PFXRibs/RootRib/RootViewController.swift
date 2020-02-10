//
//  RootViewController.swift
//  PFXRibs
//
//  Created by succorer on 2020/02/10.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import RIBs
import SnapKit
import UIKit

// 뷰 콘트롤러와 interactor 클래스와의 소통 프로토콜.
protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

// RootPresentable와 RootViewControllable 프로토콜을 받는다.
final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    // 뷰 콘트롤러와 interactor 클래스와의 소통 프로토콜 변수.
    weak var listener: RootPresentableListener?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    }

    // MARK: - RootViewControllable
    // RootViewControllable 프로토콜에 있으며 다른 화면으로 이동 함수 정의.
    func replaceModal(viewController: ViewControllable?) {
        targetViewController = viewController

        guard !animationInProgress else {
            return
        }

        if presentedViewController != nil {
            animationInProgress = true
            dismiss(animated: true) { [weak self] in
                if self?.targetViewController != nil {
                    self?.presentTargetViewController()
                } else {
                    self?.animationInProgress = false
                }
            }
        } else {
            presentTargetViewController()
        }
    }

    // MARK: - Private
    // 이동 할 화면 콘트롤러.
    private var targetViewController: ViewControllable?
    // 애니메이션 체크 변수.
    private var animationInProgress = false
    // 화면 이동 함수.
    private func presentTargetViewController() {
        if let targetViewController = targetViewController {
            animationInProgress = true
            present(targetViewController.uiviewController, animated: true) { [weak self] in
                self?.animationInProgress = false
            }
        }
    }
}

// MARK: LoggedInViewControllable
