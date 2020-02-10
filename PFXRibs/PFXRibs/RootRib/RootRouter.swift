//
//  RootRouter.swift
//  PFXRibs
//
//  Created by succorer on 2020/02/10.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func replaceModal(viewController: ViewControllable?)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()

        routeToLoggedOut()
    }

    // MARK: - Private

    private let loggedOutBuilder: LoggedOutBuildable

    private var loggedOut: ViewableRouting?

    private func routeToLoggedOut() {
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        viewController.replaceModal(viewController: loggedOut.viewControllable)
    }
}
