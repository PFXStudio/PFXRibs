//
//  LoggedOutViewController.swift
//  PFXRibs
//
//  Created by succorer on 2020/02/10.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import RIBs
import RxCocoa
import RxSwift
import SnapKit
import UIKit

// Interactor에 전달 할 수 있는 프로토콜 정의
protocol LoggedOutPresentableListener: class {
    func login(withPlayer1Name: String?, player2Name: String?)
}

// LoggedOutViewController 클래스ㅡ LoggedOutPresentable, LoggedOutViewControllable 프로토콜을 받는다.
final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
    // LoggedOutPresentable에 있는 프로토콜 작성
    weak var listener: LoggedOutPresentableListener?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let playerFields = buildPlayerFields()
        buildLoginButton(withPlayer1Field: playerFields.player1Field, player2Field: playerFields.player2Field)
    }

    // MARK: - Private
    // playerfields 생성, Snapkit을 사용하여 제약조건 작성
    private func buildPlayerFields() -> (player1Field: UITextField, player2Field: UITextField) {
        let player1Field = UITextField()
        player1Field.borderStyle = UITextField.BorderStyle.line
        view.addSubview(player1Field)
        player1Field.placeholder = "Player 1 name"
        player1Field.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(100)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(40)
        }

        let player2Field = UITextField()
        player2Field.borderStyle = UITextField.BorderStyle.line
        view.addSubview(player2Field)
        player2Field.placeholder = "Player 2 name"
        player2Field.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player1Field.snp.bottom).offset(20)
            maker.left.right.height.equalTo(player1Field)
        }

        return (player1Field, player2Field)
    }

    // loginButton 생성, Snapkit을 사용하여 제약조건 작성
    // loginButton.rx.tap 구독 작성. 탭이 이루어지면 player1Field, player2Field 문자열 값을 Interactor에 전달 한다.
    private func buildLoginButton(withPlayer1Field player1Field: UITextField, player2Field: UITextField) {
        let loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player2Field.snp.bottom).offset(20)
            maker.left.right.height.equalTo(player1Field)
        }
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = UIColor.black
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.listener?.login(withPlayer1Name: player1Field.text, player2Name: player2Field.text)
            })
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()
}
