//
//  Verifiers.swift
//  CustomAuth Sample
//
//  Created by Minh-Phuc Tran on 03/12/2021.
//

import Foundation

struct Verifier: Hashable, Codable {
    var displayName: String? = nil
    var typeOfLogin: String
    var verifier: String
    var clientId: String
}

struct AggregateVerifier: Hashable, Codable {
    var displayName: String? = nil
    var id: String
    var verifiers: [Verifier]
}

func getVerifierJwtParams(_ verifier: Verifier) -> [String:String] {
    switch(verifier.typeOfLogin) {
    case "apple", "github", "linkedin", "twitter", "line", "Username-Password-Authentication":
        return ["domain": data.proxyDomain]
    case "jwt":
        return [
            "domain": data.proxyDomain,
            "verifierIdField": "name"
        ]
    default:
        return [:]
    }
}
