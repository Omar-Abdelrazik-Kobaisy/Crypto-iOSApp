//
//  CoinDataService.swift
//  Crypto-Currency
//
//  Created by Omar on 13/01/2024.
//

import Foundation
import Combine


class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    var networkManager: NetworkProtocol
    var coinSubscription: AnyCancellable?
    init(networkManager: NetworkProtocol = NetworkManager()){
        self.networkManager = networkManager
        getCoins()
    }
    func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en") else{
            print("bad URL")
            return
        }
        
        coinSubscription = networkManager.download(fromURL: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: networkManager.handleCompletion(completion:), receiveValue: {[weak self] coins in
                guard let self else{return}
                self.allCoins = coins
                self.coinSubscription?.cancel()
            })
    }
}
