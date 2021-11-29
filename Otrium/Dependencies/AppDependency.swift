//
//  AppDependency.swift
//  Otrium
//
//  Created by Kostiantyn Gorbunov on 29/11/2021.
//

protocol Dependency {
    var dataProvider: DataProvider { get }
}

class AppDependency: Dependency {

    let dataProvider: DataProvider = LiveProfileDataProvider()
}
