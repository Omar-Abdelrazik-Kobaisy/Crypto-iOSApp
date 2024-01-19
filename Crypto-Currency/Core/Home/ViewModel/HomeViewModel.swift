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
    private let dataService: CoinDataService
    var cancel = Set<AnyCancellable>()
    
    init(dataService: CoinDataService = CoinDataService()){
        self.dataService = dataService
        addSubscribers()
    }
    
    func addSubscribers(){
        dataService.$allCoins
            .sink {[weak self] coins in
                guard let self else{return}
                self.allCoins = coins
            }
            .store(in: &cancel)
    }
}
