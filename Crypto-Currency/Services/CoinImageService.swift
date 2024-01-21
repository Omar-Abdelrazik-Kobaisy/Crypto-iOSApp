//
//  CoinImageService.swift
//  Crypto-Currency
//
//  Created by Omar on 21/01/2024.
//

import Foundation
import SwiftUI
import Combine

final class CoinImageService{
    @Published var image: UIImage? = nil
    let coin: CoinModel
    var networkManager: NetworkProtocol
    private var coinImageSubscription: AnyCancellable?
    init(networkManager: NetworkProtocol = NetworkManager(),
         coin: CoinModel){
        self.networkManager = networkManager
        self.coin = coin
        getImage()
    }
    func getImage(){
        guard let url = URL(string: coin.image ?? "") else{
            print("bad URL")
            return
        }
        
        coinImageSubscription = networkManager.download(fromURL: url)
            .tryMap({ output in
                return UIImage(data: output)
            })
            .sink(receiveCompletion: networkManager.handleCompletion(completion:), receiveValue: {[weak self] image in
                guard let self else{return}
                self.image = image
                self.coinImageSubscription?.cancel()
            })
    }
}
