//
//  Data.swift
//  CustomAuth Sample
//
//  Created by Minh-Phuc Tran on 03/12/2021.
//

import Foundation

struct AppData: Hashable, Codable {
    var browserRedirectUri: String
    var redirectUri: String
    var proxyDomain: String
    var verifiers: [Verifier]
    var aggregateVerifier: AggregateVerifier
}

var data: AppData = loadPropertylist("Auth")
var verifiers = data.verifiers

func loadPropertylist<T: Decodable>(_ filename: String) -> T {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "plist")
    else {
        fatalError("Couldn't find \(filename).plist in main bundle.")
    }

    let data: Data
    do {
        data = try Data(contentsOf: url)
    } catch {
        fatalError("Couldn't load \(filename).plist from main bundle: \(error)")
    }

    do {
        let decoder = PropertyListDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self): \(error)")
    }
}
