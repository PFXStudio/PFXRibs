//
//  RootInteractor.swift
//  PFXRibs
//
//  Created by succorer on 2020/02/10.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import RIBs
import RxSwift

// 라우터에 호출이 필요 할 경우 RootRouting 프로토콜에 정의 해서 전달한다.
protocol RootRouting: ViewableRouting {
}

// Presentable 프로토콜을 통해 RootViewController를 연결 해 준다.
// RootViewController에서 이벤트가 발생하면 Presentable 프로토콜을 통해 Interactor에게 전달한다.
protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

// Interactor에 접근 할 수 있는 함수 프로토콜. 즉 Interactor에 접근 할 수 있는 함수 목록 기재.
protocol RootListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

// RootInteractor 클래스. PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener, UrlHandler 프로토콜 사용.
final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener, UrlHandler {
    // 라우터 참조 변수
    weak var router: RootRouting?
    
    // listener를 통해 다른 Interactor 접근?
    weak var listener: RootListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    // presenter는 ViewController를 받는다.
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    // Interactor 생명 주기 함수
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    // Interactor 생명 주기 함수
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    // MARK: - LoggedOutListener

    // LoggedOut RIB에서 호출 되는 함수 정의, LoggedOutListener 프로토콜을 통한다.
    func didLogin(withPlayer1Name player1Name: String, player2Name: String) {
    }

    // MARK: - UrlHandler
    // handle 함수 정의.
    func handle(_ url: URL) {
    }

    // MARK: - RootActionableItem

    // MARK: - Private
}
