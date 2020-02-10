//
//  LoggedOutBuilder.swift
//  PFXRibs
//
//  Created by succorer on 2020/02/10.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import RIBs

import RIBs

// 생성 시 다른 RIB의 필요한 변수, 함수를 프로토콜에 정의 해야 한다.
// 변수는 프로퍼티 get으로 정의하며 RIB의 변수명과 동일하게 기재해야 한다.
protocol LoggedOutDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

// 의존성 관리 객체 생성
final class LoggedOutComponent: Component<LoggedOutDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder
// 생성 시 필요한 정보를 프로토콜에 정의 한다.
protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

// LoggedOutBuilder 클래스, LoggedOutDependency, LoggedOutBuildable 프로토콜을 받는다.
final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {
    // 빌더 클래스 생성 시 의존성을 받는다.
    // LoggedOutDependency 프로토콜을 받기 때문에 LoggedOutDependency 정의 된 사항만 접근 할 수 있다.
    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }

    // 생성 함수, 리턴 값은 LoggedOutRouting
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        _ = LoggedOutComponent(dependency: dependency)
        let viewController = LoggedOutViewController()
        let interactor = LoggedOutInteractor(presenter: viewController)
        interactor.listener = listener
        return LoggedOutRouter(interactor: interactor, viewController: viewController)
    }
}
