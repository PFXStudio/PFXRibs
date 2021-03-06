//
//  RootBuilder.swift
//  PFXRibs
//
//  Created by succorer on 2020/02/10.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import RIBs

// 생성 시 다른 RIB의 필요한 변수, 함수를 프로토콜에 정의 해야 한다.
// 변수는 프로퍼티 get으로 정의하며 RIB의 변수명과 동일하게 기재해야 한다.
protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

// 의존성 관리 객체
final class RootComponent: Component<RootDependency> {

    let rootViewController: RootViewController

    // 의존성과 콘트롤러를 받아 생성한다.
    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

// 생성 시 필요한 정보를 프로토콜에 정의 한다.
protocol RootBuildable: Buildable {
    func build() -> (launchRouter: LaunchRouting, urlHandler: UrlHandler)
}

// 빌더 클래스 정의
final class RootBuilder: Builder<RootDependency>, RootBuildable {
    // 빌더 클래스 생성 시 의존성을 받는다.
    // RootDependency 프로토콜을 받기 때문에 RootDependency 정의 된 사항만 접근 할 수 있다.
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    // 생성 함수, 리턴 값은 LaunchRouting, UrlHandler.
    // LaunchRouting 라우터, UrlHandler는 외부로 부턴 openUrl 호출이 들어 올 경우 handler 사용
    func build() -> (launchRouter: LaunchRouting, urlHandler: UrlHandler) {
        // 콘트롤러 객체 생성
        let viewController = RootViewController()
        // 의존성 관리 객체 생성
        let component = RootComponent(dependency: dependency,
                                      rootViewController: viewController)
        // 비즈니스 로직 관리 객체 생성
        let interactor = RootInteractor(presenter: viewController)
        
        // LoggedOutBuilder 생성 시 의존성을 주어 생성
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        // 라우터 객체 생성
        let router = RootRouter(interactor: interactor,
                                viewController: viewController,
                                loggedOutBuilder: loggedOutBuilder)

        return (router, interactor)
    }
}
