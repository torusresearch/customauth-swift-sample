//
//  Web3AuthManager.swift
//  OpenLoginKeyViewer
//
//  Created by Dhruv Jaiswal on 03/11/22.
//

import Foundation
import FetchNodeDetails
import CustomAuth
import UIKit

class CustomAuthManager: ObservableObject {
    private var customAuth: CustomAuth?
    private var network: Network
    init() {
        self.network = .testnet
    }
    
    func changeNetwork(network: Network) {
        self.network = network
    }
    

    func login(provider: CustomAuthProvider) async throws -> [String:Any] {
        switch provider{
        case .GOOGLE:
            googleLogin()
        case .FACEBOOK:
            facebookLogin()
        case .REDDIT:
            redditLogin()
        case .DISCORD:
            discordLogin()
        case .TWITCH:
            twitchLogin()
        case .APPLE:
            appleLogin()
        case .GITHUB:
            githubLogin()
        case .KAKAO:
            kakaoLogin()
        case .LINKEDIN:
            linkedinLogin()
        case .TWITTER:
            twitterLogin()
        case .WECHAT:
            wechatLogin()
        case .EMAIL_PASSWORDLESS:
            emailPasswordlessLogin()
        case .WEIBO:
            weiboLogin()
        }
        let result = try await triggerLogin()
        return result
    }

    func logout() async throws {
    }
}

extension CustomAuthManager{

        func removeUser() {
            customAuth = nil
        }

           func triggerLogin() async throws -> [String:Any] {
            let vc = await UIApplication.shared.keyWindow?.rootViewController
                do{
                
                    let data = try await customAuth?.triggerLogin(controller: vc)
                    return data ?? [:]
                }catch {
                   throw error
                }
        }

        func googlePolygonLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .google,
                                         clientId: "908137525998-fs00a3go5r7fpbntmui4lb8nhuqqtmaa.apps.googleusercontent.com",
                                         verifier: "polygon-ios-test",
                                         redirectURL: "torus://org.torusresearch.sample/redirect",
                                         browserRedirectURL: "https://scripts.toruswallet.io/redirect.html",
                                         jwtParams: ["prompt": "login"],
                                         urlSession: URLSession.shared)
            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "polygon-ios-test", subVerifierDetails: [sub], network: .CYAN, urlSession: URLSession.shared)
        }

        func googleLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .google,
                                         clientId: "221898609709-obfn3p63741l5333093430j3qeiinaa8.apps.googleusercontent.com",
                                         verifier: "google-lrc",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         browserRedirectURL: "https://scripts.toruswallet.io/redirect.html",
                                         jwtParams: ["prompt": "login"])

            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "google-lrc", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET)
        }

        func redditLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .reddit,
                                         clientId: "rXIp6g2y3h1wqg",
                                         verifier: "reddit-shubs",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         urlSession: URLSession.shared)
            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "reddit-shubs", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }

        func discordLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .discord,
                                         clientId: "1034724991972954172",
                                         verifier: "dhruv-discord",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         browserRedirectURL: "https://scripts.toruswallet.io/redirect.html",
                                         urlSession: URLSession.shared)
            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "dhruv-discord", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }

        func facebookLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .facebook,
                                         clientId: "659561074900150",
                                         verifier: "facebook-shubs",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         browserRedirectURL: "https://scripts.toruswallet.io/redirect.html",
                                         urlSession: URLSession.shared)

            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "facebook-shubs", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }

        func twitchLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .twitch,
                                         clientId: "p560duf74b2bidzqu6uo0b3ot7qaao",
                                         verifier: "twitch-shubs",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         urlSession: URLSession.shared)
            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "twitch-shubs", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }

        func twitterLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .twitter,
                                         clientId: "A7H8kkcmyFRlusJQ9dZiqBLraG2yWIsO",
                                         verifier: "torus-auth0-twitter-lrc",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         jwtParams: ["domain": "torus-test.auth0.com", "connection": "twitter"],
                                         urlSession: URLSession.shared)

            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "torus-auth0-twitter-lrc", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }

        func githubLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .github,
                                         clientId: "PC2a4tfNRvXbT48t89J5am0oFM21Nxff",
                                         verifier: "torus-auth0-github-lrc",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         jwtParams: ["domain": "torus-test.auth0.com", "connection": "github"],
                                         urlSession: URLSession.shared)

            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "torus-auth0-github-lrc", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }

        func linkedinLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .linkedin,
                                         clientId: "59YxSgx79Vl3Wi7tQUBqQTRTxWroTuoc",
                                         verifier: "torus-auth0-linkedin-lrc",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         jwtParams: ["domain": "torus-test.auth0.com", "connection": "linkedin"],
                                         urlSession: URLSession.shared)

            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "torus-auth0-linkedin-lrc", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }

        func appleLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .apple,
                                         clientId: "m1Q0gvDfOyZsJCZ3cucSQEe9XMvl9d9L",
                                         verifier: "torus-auth0-apple-lrc",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         jwtParams: ["domain": "torus-test.auth0.com", "connection": "apple"],
                                         urlSession: URLSession.shared)

            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "torus-auth0-apple-lrc", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }

        func emailPasswordlessLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .jwt,
                                         clientId: "P7PJuBCXIHP41lcyty0NEb7Lgf7Zme8Q",
                                         verifier: "torus-auth0-email-passwordless",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         jwtParams: ["domain": "torus-test.auth0.com", "verifier_id_field": "name"],
                                         urlSession: URLSession.shared)

            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "torus-auth0-email-passwordless", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }

        func kakaoLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .kakao,
                                         clientId: "wpkcc7alGJjEgjaL6q5AWRqgRWHFsdTL",
                                         verifier: "torus-auth0-kakao-lrc",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         jwtParams: ["domain": "torus-test.auth0.com"],
                                         urlSession: URLSession.shared)

            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "torus-auth0-kakao-lrc", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }

        func weiboLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .apple,
                                         clientId: "dhFGlWQMoACOI5oS5A1jFglp772OAWr1",
                                         verifier: "torus-auth0-weibo-lrc",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         jwtParams: ["domain": "torus-test.auth0.com"],
                                         urlSession: URLSession.shared)

            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "torus-auth0-weibo-lrc", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }

        func wechatLogin() {
            let sub = SubVerifierDetails(loginType: .web,
                                         loginProvider: .wechat,
                                         clientId: "cewDD3i6F1vtHeV1KIbaxUZ8vJQjJZ8V",
                                         verifier: "torus-auth0-wechat-lrc",
                                         redirectURL: "tdsdk://tdsdk/oauthCallback",
                                         jwtParams: ["domain": "torus-test.auth0.com"],
                                         urlSession: URLSession.shared)

            customAuth = CustomAuth(aggregateVerifierType: .singleLogin, aggregateVerifier: "torus-auth0-wechat-lrc", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }

        func googleDeepLinkFlowLogin() {
            let sub = SubVerifierDetails(loginType: .installed,
                                         loginProvider: .google,
                                         clientId: "238941746713-vfap8uumijal4ump28p9jd3lbe6onqt4.apps.googleusercontent.com",
                                         verifier: "google-ios",
                                         redirectURL: "com.googleusercontent.apps.238941746713-vfap8uumijal4ump28p9jd3lbe6onqt4:/oauthredirect",
                                         urlSession: URLSession.shared)
            customAuth = CustomAuth(aggregateVerifierType: .singleIdVerifier, aggregateVerifier: "multigoogle-torus", subVerifierDetails: [sub], factory: CASDKFactory(), network: .TESTNET, urlSession: URLSession.shared)
        }
    }


enum Network:Codable{
    case testnet
}

//extension EthereumNetworkFND{
//    mutating func convertETHFndNetworkToNetwork(val:EthereumNetworkFND) -> Network {
//        switch val {
//        case .MAINNET:
//            return Network.mainnet
//        case .TESTNET:
//            return Network.testnet
//        case .CYAN:
//            return Network.cyan
//        case .AQUA:
//            return Network.cyan
//        case .CELESTE:
//            return Network.cyan
//        case .CUSTOM(let path):
//            return Network.cyan
//        }
//    }
//}
