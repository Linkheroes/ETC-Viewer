//
//  account.swift
//  Nanopool
//
//  Created by Alexandre Ricard on 16/08/2021.
//

import Foundation

struct userSettings: Codable {
    var status: Bool
    var data: userSettingsResult
}

struct userSettingsResult: Codable {
    var payout: Double
}

struct currentETHBalance: Codable {
    var status: Bool
    var data: currentETHBalanceResult
}

struct currentETHBalanceResult: Codable {
    var price_usd: Double
    var price_eur: Double
}


