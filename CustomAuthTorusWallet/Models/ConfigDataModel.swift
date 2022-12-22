//
//  ConfigDataModel.swift
//  OpenLoginKeyViewer
//
//  Created by Dhruv Jaiswal on 06/11/22.
//

import Foundation

struct ConfigDataStruct: Codable {
    var blockchain: BlockchainEnum
    var network: Network
    var isLoggedIn: Bool
    var user:User
}
