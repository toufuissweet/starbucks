//
//  StarbucksApp.swift
//  Shared
//
//  Created by 小天才智能电脑 on 2020/12/4.
//

import SwiftUI

@main
struct StarbucksApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(Store())
                .environment(\.locale, .init(identifier:"zh_cn"))
        }
    }
}
