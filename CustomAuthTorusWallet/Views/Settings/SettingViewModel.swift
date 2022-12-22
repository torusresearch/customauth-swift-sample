//
//  SettingViewModel.swift
//  OpenLoginKeyViewer
//
//  Created by Dhruv Jaiswal on 13/11/22.
//

import Combine
import Foundation
import UIKit

class SettingVM: ObservableObject {
    var blockchain: BlockchainEnum {
        manager.type
    }
    var user: User {
        blockchainManager.user
    }

    var getTheme: Theme {
        return theme
    }

    private var theme: Theme = .system
    private var blockchainManager: BlockchainManagerProtocol
    private var manager: BlockChainProtocol
    private var cancellables: Set<AnyCancellable> = []
    init(blockchainManager: BlockchainManagerProtocol) {
        self.blockchainManager = blockchainManager
        manager = blockchainManager.manager
        blockchainManager.blockchainDidChange.sink { completionVal in
            print(completionVal)
        } receiveValue: {[unowned self] manager in
            self.manager = blockchainManager.manager
            objectWillChange.send()
        }.store(in: &cancellables)
        if let data = UserDefaultsManager.shared.get(key: .theme),
        let theme = try? JSONDecoder().decode(Theme.self, from: data)
        {
            changeTheme(val: theme)
        }
    }

    func changeBlockchain(val: BlockchainEnum) {
        blockchainManager.changeBlockChain(blockchain: val)
    }

    func logout() {
        manager.logout()
    }

    func changeTheme(val: Theme) {
        self.theme = val
        if let data = try? JSONEncoder().encode(theme){
            UserDefaultsManager.shared.save(key: .theme, val: data)
        }
        UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = theme.getUIUserInterfaceStyle()
        objectWillChange.send()
    }
}

enum Theme: CaseIterable, MenuPickerProtocol, Hashable, Codable, Identifiable {
    var id: String { UUID().uuidString }

    var name: String {
        switch self {

        case .system:
           return "System"
        case .light:
           return "Light"
        case .dark:
           return "Dark"
        }
    }

    func getUIUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .system:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }

    case system
    case light
    case dark
}
