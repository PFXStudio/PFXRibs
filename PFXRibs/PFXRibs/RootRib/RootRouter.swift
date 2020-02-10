//
//  RootRouter.swift
//  PFXRibs
//
//  Created by succorer on 2020/02/10.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import RIBs

// LoggedOutListener 사용할 RIB와의 소통 프로토콜
// LoggedOutRIB에서 LoggedOutListener 통해 이벤트를 전달 받는다.
// 즉, LoggedOutRIB에서 LoggedOutListener 정의 된 이벤트만 전달 받을 수 있다.
protocol RootInteractable: Interactable, LoggedOutListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // 다른 화면으로 이동 할 경우 RootViewController에 정의 해야 함
    func replaceModal(viewController: ViewControllable?)
}

// RootRouter는 RootInteractable, RootViewControllable, RootRouting 프로토콜을 갖어야 한다.
// RootRouting 프로토콜은 다른 RIB를 연결 할 경우 프로토콜에 정의 한 후 사용한다.
final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // 생성시 의존성 주입을 시켜준다.
    // RootInteractable, RootViewControllable, LoggedOutBuildable 의존성을 갖고 생성한다.
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuildable) {
        // 부모 호출 전에 클래스 내에 인스턴스 변수를 초기화 한 후 부모를 호출 해야 한다. 안하면 컴파일 오류가 나버림
        self.loggedOutBuilder = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        // interactor에 router를 설정한다.
        // interactor에서 router 쪽으로 무언가 전달 할 사항이 생길 때 사용할려는 거 같음.
        // 전달 할 사항이 있으면 RootRouting 프로토콜에 정의를 한 후 전달 하면 될 듯.
        interactor.router = self
    }

    // viewdidload와 같이 초기화 과정이 필요 할 때 재정의 하여 사용한다.
    override func didLoad() {
        super.didLoad()
        
        // LoggedOut RIB를 생성하여 연결하는 작업을 함.
        routeToLoggedOut()
    }

    // MARK: - Private
    // LoggedOutBuildable 프로토콜 변수.
    private let loggedOutBuilder: LoggedOutBuildable

    // ViewableRouting 프로토콜 변수.
    private var loggedOut: ViewableRouting?

    // 연결 함수 정의
    private func routeToLoggedOut() {
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        // 루트 화면에서 loggedOut 화면으로 변경한다.
        viewController.replaceModal(viewController: loggedOut.viewControllable)
    }
}
