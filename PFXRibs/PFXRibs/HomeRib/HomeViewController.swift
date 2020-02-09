//
//  HomeViewController.swift
//  PFXRibs
//
//  Created by succorer on 09/02/2020.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol HomePresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class HomeViewController: UIViewController, HomePresentable, HomeViewControllable {

    weak var listener: HomePresentableListener?
}
