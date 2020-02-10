//
//  AppComponent.swift
//  PFXRibs
//
//  Created by succorer on 2020/02/10.
//  Copyright © 2020 PFXStudio. All rights reserved.
//

import Foundation
import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }
}
