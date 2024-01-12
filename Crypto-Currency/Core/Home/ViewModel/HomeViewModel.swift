//
//  HomeViewModel.swift
//  Crypto-Currency
//
//  Created by Omar on 11/01/2024.
//

import Foundation

class HomeViewModel: ObservableObject{
    @Published var livePriceCoins: [CoinModel] = []
    @Published var PortfolioCoins: [CoinModel] = []
    
    init(){
        DispatchQueue.main.async {
            self.livePriceCoins.append(DeveloperPreview.instance.coin)
        }
        
    }
}
