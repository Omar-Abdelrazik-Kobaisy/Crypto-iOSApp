//
//  HomeViewModel.swift
//  Crypto-Currency
//
//  Created by Omar on 11/01/2024.
//

import Foundation
import Combine
class HomeViewModel: ObservableObject{
//    @Published var livePriceCoins: [CoinModel] = []
//    @Published var portfolioCoins: [CoinModel] = []
    @Published var allCoins: [CoinModel] = []
    private let dataService: CoinDataServiceProtocol
//    var coinSubscription: AnyCancellable?
    var cancel = Set<AnyCancellable>()
    
    init(dataService: CoinDataServiceProtocol = CoinDataService()){
        self.dataService = dataService
        addSubscribers()
//        DispatchQueue.main.async {[weak self] in
//            self?.livePriceCoins.append(DeveloperPreview.instance.coin)
//            self?.portfolioCoins.append(DeveloperPreview.instance.coin)
//        }
    }
    
    func addSubscribers(){
        dataService.getCoins()
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
                print(self.allCoins)
//                self.coinSubscription?.cancel()
            }
            .store(in: &cancel)

    }
}
