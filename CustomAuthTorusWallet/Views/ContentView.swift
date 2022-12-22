//
//  ContentView.swift
//  OpenLoginKeyViewer
//
//  Created by Dhruv Jaiswal on 19/11/22.
//

import SwiftUI
import Combine
import UIKit

struct ContentView: View {

   @StateObject private var authManager: AuthManager = .init()
   @State private var selectedTab = 0

    var body: some View {
        if authManager.loading {
         LoadingView()
                .ignoresSafeArea()
        } else {
            if let user = authManager.user, let blockchainManager = BlockchainManager(authManager: authManager, user: user) {
            TabView(selection: $selectedTab) {
                    HomeView(vm: .init(blockchainManager: blockchainManager), selectedTab: $selectedTab)
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                        .tag(0)
                    SettingView(vm: .init(blockchainManager: blockchainManager))
                        .tabItem {
                            Label("Setting", systemImage: "gear")

                        }
                        .tag(1)
                }
                .accentColor(Color.tabBarColor())
            } else {
                LoginHomePageview(vm: .init(authManager: authManager))
                
            }
        }
    }
    
   
}
