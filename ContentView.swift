//
//  ContentView.swift
//  CustomAuth Sample
//
//  Created by Minh-Phuc Tran on 01/12/2021.
//

import SwiftUI
import CustomAuth

struct LoginResult {
    var privateKey: String;
    var publicAddress: String;
}

struct ContentView: View {
    @State private var showResult = false
    @State private var result: LoginResult? = nil
    
    var body: some View {
        NavigationView {
            List {
                if showResult {
                    Section(header: Text("Result")) {
                        if let result = result {
                            HStack(alignment: .top) {
                                Text("Address").font(.body).fontWeight(.medium)
                                Text(result.publicAddress).lineLimit(1)
                            }
                            HStack(alignment: .top) {
                                Text("Key").font(.body).fontWeight(.medium)
                                Text(result.privateKey).lineLimit(1)
                            }
                        } else {
                            ProgressView()
                        }
                    }
                }
                
                Section(header:
                            Text("Single-verifier Login")) {
                    ForEach(0 ..< verifiers.count) { index in
                        let verifier = verifiers[index]
                        Button {
                            login(verifier)
                        } label: {
                            Text(verifier.displayName ?? verifier.typeOfLogin.capitalized)
                        }
                    }
                }
                
                Section(header:
                            Text("Multiple-verifier Login")) {
                    Text("This example demonstrates aggregate login using only Google. You can use all available login types. See docs.tor.us for details.")
                        .font(.footnote)
                        .padding(.vertical, 8)
                    Button {
                        aggregateLogin()
                    } label: {
                        Text("Google")
                    }
                }
                
            } .navigationBarTitle("CustomAuth Sample")
        }
    }
    
    func login(_ verifier: Verifier) -> Void {
        let customAuth = CustomAuth(
            aggregateVerifierType: .singleLogin,
            aggregateVerifierName: verifier.verifier,
            subVerifierDetails: [SubVerifierDetails(
                loginType: .web,
                loginProvider: LoginProviders(rawValue: verifier.typeOfLogin)!,
                clientId: verifier.clientId,
                verifierName: verifier.verifier,
                redirectURL: data.redirectUri,
                browserRedirectURL: data.browserRedirectUri,
                jwtParams: getVerifierJwtParams(verifier)
            )],
            network: .ROPSTEN
        )
        
        result = nil
        showResult = true
        
        customAuth.triggerLogin(browserType: .external)
            .done { data in
                result = LoginResult(
                    privateKey: data["privateKey"] as! String,
                    publicAddress: data["publicAddress"] as! String
                )
                print(data)
            }.catch { err in
                showResult = false
            }
    }
    
    func aggregateLogin() {
        var verifiers: [SubVerifierDetails] = []
        for verifier in data.aggregateVerifier.verifiers {
            verifiers.append(SubVerifierDetails(
                loginType: .web,
                loginProvider: LoginProviders(rawValue: verifier.typeOfLogin)!,
                clientId: verifier.clientId,
                verifierName: verifier.verifier,
                redirectURL: data.redirectUri,
                browserRedirectURL: data.browserRedirectUri,
                jwtParams: getVerifierJwtParams(verifier)
            ))
        }
        
        let customAuth = CustomAuth(
            aggregateVerifierType: .singleIdVerifier,
            aggregateVerifierName: data.aggregateVerifier.id,
            subVerifierDetails: verifiers,
            network: .ROPSTEN
        )
        
        result = nil
        showResult = true
        
        customAuth.triggerLogin(browserType: .external)
            .done { data in
                result = LoginResult(
                    privateKey: data["privateKey"] as! String,
                    publicAddress: data["publicAddress"] as! String
                )
                print(data)
            }.catch { err in
                showResult = false
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
