//
//  CustomAuth_SampleApp.swift
//  CustomAuth Sample
//
//  Created by Minh-Phuc Tran on 01/12/2021.
//

import SwiftUI
import CustomAuth

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL { url in
                CustomAuth.handle(url: url)
            }
        }
    }
}
