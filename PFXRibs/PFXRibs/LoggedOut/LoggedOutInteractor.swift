//
//  LoggedOutInteractor.swift
//  PFXRibs
//
//  Created by succorer on 2020/02/10.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import RIBs
import RxSwift

// 인터랙터에서 라우터로 통신을 하기 위한 프로토콜, 라우터에서 기능 구현을 해야 함
protocol LoggedOutRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func messageToRouter(message: String)
}

extension LoggedOutRouting {
    // 공부 중..
    func messageToRouter(message: String = "") {
    }
    
    func messageToClass(message: String) where Self: Hashable {
    }
}

// Presentable 프로토콜을 통해 LoggedOutViewController를 연결 해 준다.
// LoggedOutViewController에서 이벤트가 발생하면 Presentable 프로토콜을 통해 Interactor에게 전달한다.
// 뷰컨에서 인터랙터로 전달이 필요할 때 Presentable 채택해서 정의 한다.
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
    // 인터랙터 끼리 통신이 필요 한 경우에는 리스너 프로토콜을 이용 해 전달한다.
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
