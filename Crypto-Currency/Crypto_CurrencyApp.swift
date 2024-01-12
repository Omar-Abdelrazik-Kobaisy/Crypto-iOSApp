//
//  Crypto_CurrencyApp.swift
//  Crypto-Currency
//
//  Created by Omar on 06/01/2024.
//

import SwiftUI

@main
struct Crypto_CurrencyApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.hidden, for: .navigationBar)
            }
            .environmentObject(vm)
        }
    }
}
