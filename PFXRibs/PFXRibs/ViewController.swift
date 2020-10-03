//
//  ViewController.swift
//  PFXRibs
//
//  Created by succorer on 09/02/2020.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import UIKit

protocol Checkable {
    func valid() -> Bool
    var name: String { get }
}

// 뷰컨에만 확장 프로토콜이 적용 됨
extension Checkable where Self: UIViewController {
    func invalid() -> Bool { return false }
}

extension Checkable {
    // 뷰컨에만 확장 프로토콜 함수가 적용 됨
    func isValid() -> Bool where Self: UIViewController { return false }
}

class ViewController: UIViewController, Checkable {
    var name: String = ""
    
    func valid() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.invalid()
        self.isValid()
    }


}

