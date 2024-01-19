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
    var coinSubscription: AnyCancellable?
    init(){
        getCoins()
    }
    func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en") else{
            print("bad URL")
            return
        }
        
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else{
                    print("inValid Response")
                    throw URLError(.badServerResponse)
                }
                print("🚀-> "+output.response.debugDescription)
                return output.data
            }
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Successfully Decoded data into CoinModel")
                case .failure(let error):
                    print("can't decode data into CoinModel ->"+error.localizedDescription)
                }
            } receiveValue: {[weak self] coins in
                guard let self else{return}
                self.allCoins = coins
                self.coinSubscription?.cancel()
            }

    }
}
