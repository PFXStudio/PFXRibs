//
//  LoggedOutRouter.swift
//  PFXRibs
//
//  Created by succorer on 2020/02/10.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import RIBs
import RxSwift

// Interactor 프로토콜 정의
protocol LoggedOutInteractable: Interactable {
    var router: LoggedOutRouting? { get set }
    var listener: LoggedOutListener? { get set }
}

// 뷰 콘트롤러 프로토콜
protocol LoggedOutViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

// LoggedOutRouter 클래스, LoggedOutInteractable, LoggedOutViewControllable, LoggedOutRouting 프로토콜을 사용한다.
final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>, LoggedOutRouting, Hashable {
    public var hashableIdentifier: AnyHashable {
        return self
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashableIdentifier)
    }
    static func == (lhs: LoggedOutRouter, rhs: LoggedOutRouter) -> Bool {
        return false
    }
    
    // TODO: Constructor inject child builder protocols to allow building children.
    // LoggedOutBuilder 빌더를 통해 Interactor와 뷰 콘트롤러를 받아 LoggedOutRouter 객체를 생성한다.
    override init(interactor: LoggedOutInteractable, viewController: LoggedOutViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        // interactor에게 라우터 객체를 참조 시킨다.
        interactor.router = self
    }
    func messageToRouter(message: String) {
        print("received message from interactor \(message)")
    }
}
