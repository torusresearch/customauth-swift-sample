//
//  AuthManager.swift
//  OpenLoginKeyViewer
//
//  Created by Dhruv Jaiswal on 02/11/22.
//

import Foundation
import FetchNodeDetails
import CustomAuth
import TorusEd25519Key

class AuthManager: ObservableObject {
    @Published var user: User?
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var loading: Bool = false
    @Published var showSpinner:Bool = false
    private var customAuthManager: CustomAuthManager?
    var blockchain: BlockchainEnum = .ETHMainnet
    var network: Network = .testnet

    init() {
        loading = true
        initialLoad()
        customAuthManager = .init()
    }

    func initialLoad() {
        switch loadDataFromKeychain() {
        case let .success(data):
            self.network = data.network
            self.blockchain = data.blockchain
            self.user = data.user
        case let .failure(err):
            print(err)
        }
        loading = false
    }
}

extension AuthManager {


    func login(provider: CustomAuthProvider) {
        showSpinner = true
        Task {
            do {
                let user = try await customAuthManager?.login(provider: provider)
                decodeData(data: user ?? [:], loginType: provider)
            } catch let err {
                await MainActor.run(body: {
                    showSpinner = false
                    errorMessage = err.localizedDescription
                    showError = true
                })
             
            }
        }
    }
    
    func decodeData(data: [String: Any],loginType:CustomAuthProvider) {
        var email = ""
        var name = ""
        guard let privKey = data["privateKey"] as? String,
              let pubAddress = data["publicAddress"] as? String,
              let ed25519Key = try? ED25519.getED25519Key(privateKey: privKey).pk.toHexString() else { return }
        DispatchQueue.main.async { [weak self] in
            let dict = data["userInfo"] as? [String:Any] ?? [:]
            if dict["email"] != nil,let dictEmail = dict["email"] as? String{
                email = dictEmail
            }
            if dict["name"] != nil,let dictName = dict["name"] as? String{
                name = dictName
            }
            self?.user = User(privKey: privKey, ed25519PrivKey: ed25519Key, userInfo: .init(name: name, profileImage: "", typeOfLogin: loginType.rawValue, aggregateVerifier: "", verifier: "", verifierId: "", email: email))
        }
    }

    func logout() {
        Task{
            do {
                try await customAuthManager?.logout()
                UserDefaultsManager.shared.delete(key: .configData)
                await MainActor.run {
                    user = nil
                }
            } catch let err {
                errorMessage = err.localizedDescription
                showError = true
            }
        }
    }
}

extension AuthManager {

    func loadDataFromKeychain() -> Result<ConfigDataStruct,Error> {
        if let data = UserDefaultsManager.shared.get(key: .configData), let decodedData = try? JSONDecoder().decode(ConfigDataStruct.self, from: data) {
            return .success(decodedData)
        }
        return .failure(customError.unkown("User not found"))
    }
}


public enum CustomAuthProvider: String, Codable,CaseIterable {
    case GOOGLE = "google"
    case FACEBOOK = "facebook"
    case REDDIT = "reddit"
    case DISCORD = "discord"
    case TWITCH = "twitch"
    case APPLE = "apple"
    case GITHUB = "github"
    case KAKAO = "kakao"
    case LINKEDIN = "linkedin"
    case TWITTER = "twitter"
    case WEIBO = "weibo"
    case WECHAT = "wechat"
    case EMAIL_PASSWORDLESS = "email_passwordless"
}

enum customError:Error{
    case unkown(String)
}
