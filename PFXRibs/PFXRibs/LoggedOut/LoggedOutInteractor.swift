//
//  LoggedOutInteractor.swift
//  PFXRibs
//
//  Created by succorer on 2020/02/10.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import RIBs
import RxSwift

// 라우터에 호출이 필요 할 경우 LoggedOutRouting 프로토콜에 정의 해서 전달한다.
protocol LoggedOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

// Presentable 프로토콜을 통해 LoggedOutViewController를 연결 해 준다.
// LoggedOutViewController에서 이벤트가 발생하면 Presentable 프로토콜을 통해 Interactor에게 전달한다.
protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

// Interactor에 접근 할 수 있는 함수 프로토콜. 즉 Interactor에 접근 할 수 있는 함수 목록 기재.
// RootInteractor에서 사용함. 프로토콜을 통해서 다른 RIB interactor 호출은 괜찮은 것인가??
protocol LoggedOutListener: class {
    func didLogin(withPlayer1Name player1Name: String, player2Name: String)
}
 
// LoggedOutInteractor 클래스. LoggedOutPresentable, LoggedOutInteractable, LoggedOutPresentableListener 프로토콜을 받는다.
final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable, LoggedOutPresentableListener {
    // LoggedOutRouting 참조 변수
    weak var router: LoggedOutRouting?
    // LoggedOutListener 참조 변수
    // 생성 시 RootInteractor를 전달 받기 때문에 RootInteractor에 호출 된다.
    weak var listener: LoggedOutListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // 생성 시 LoggedOutViewController를 받는다.
    override init(presenter: LoggedOutPresentable) {
        super.init(presenter: presenter)
        // LoggedOutViewController에서 LoggedOutInteractor 호출이 가능 하도록 listener에 LoggedOutInteractor 값을 참조 시킨다.
        presenter.listener = self
    }

    // RIB 생명주기 함수
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    // RIB 생명주기 함수
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    // MARK: - LoggedOutPresentableListener
    // LoggedOutViewController 호출되는 함수 정의. LoggedOutPresentableListener 프로토콜에 정의 되어 있음.
    func login(withPlayer1Name player1Name: String?, player2Name: String?) {
        let player1NameWithDefault = playerName(player1Name, withDefaultName: "Player 1")
        let player2NameWithDefault = playerName(player2Name, withDefaultName: "Player 2")
        // RootInteractor에 didLogin을 호출한다.
        listener?.didLogin(withPlayer1Name: player1NameWithDefault, player2Name: player2NameWithDefault)
    }
    
    // playerName을 값 체크 하여 리턴해 주는 함수.
    private func playerName(_ name: String?, withDefaultName defaultName: String) -> String {
        if let name = name {
            return name.isEmpty ? defaultName : name
        } else {
            return defaultName
        }
    }
}
