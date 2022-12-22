//
//  LoginMethodSelectionPageVM.swift
//  OpenLoginKeyViewer
//
//  Created by Dhruv Jaiswal on 21/04/22.
//

import Combine
import Foundation
import UIKit

class LoginMethodSelectionPageVM: ObservableObject {
    @Published private var authManager: AuthManager
    @Published var showError: Bool = false
    @Published var errorMessage = ""
    @Published var userEmail: String = ""
    @Published var isRowExpanded: Bool = false
    @Published var network: Network = .testnet
    @Published var blockchain: BlockchainEnum = .ETHMainnet
    @Published var showSpinner:Bool = false
    var cancellables: Set<AnyCancellable> = []
    var loginRow1Arr: [CustomAuthProvider] = [.APPLE, .GOOGLE, .FACEBOOK, .TWITTER]
    var loginRow2Arr: [CustomAuthProvider] = [.REDDIT, .DISCORD, .WECHAT, .TWITCH]
    var loginRow3Arr: [CustomAuthProvider] = [.GITHUB, .LINKEDIN, .KAKAO]
    var networkArr = Network.allCases

    init(authManager: AuthManager) {
        self.authManager = authManager
        setup()
    }

    func setup() {
        authManager.$showError.sink { val in
            self.showError = val
        }
        .store(in: &cancellables)
        authManager.$errorMessage.sink { val in
            self.errorMessage = val
        }
        .store(in: &cancellables)
        $network.sink(receiveValue: { val in
            self.authManager.network = val
        })
        .store(in: &cancellables)
        $blockchain.sink(receiveValue: { val in
            self.authManager.blockchain = val
        })
        .store(in: &cancellables)
        authManager.$showSpinner.sink { completion in
            debugPrint(completion)
        } receiveValue: {[weak self]  val in
            self?.showSpinner = val
        }
        .store(in: &cancellables)
        if let data = UserDefaultsManager.shared.get(key: .theme),
           let theme = try? JSONDecoder().decode(Theme.self, from: data){
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = theme.getUIUserInterfaceStyle()
        }

    }

    func login(_ provider: CustomAuthProvider) {
        authManager.login(provider: provider)
    }

    func loginWithEmail() {
       // authManager.loginWithEmail(email: userEmail)
    }
}
