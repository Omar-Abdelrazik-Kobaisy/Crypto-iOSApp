//
//  CoinImageViewModel.swift
//  Crypto-Currency
//
//  Created by Omar on 21/01/2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject{
    @Published var image: UIImage? = nil
    @Published var isLoading = false
    private var imageService: CoinImageService
    private var cancel = Set<AnyCancellable>()
    init(coin: CoinModel){
        self.imageService = CoinImageService(coin: coin)
        isLoading = true
        addSubscribers()
    }
    
    func addSubscribers(){
        imageService.$image
            .sink {[weak self] _ in
                guard let self else{return}
                self.isLoading = false
            } receiveValue: {[weak self] image in
                guard let self else{return}
                self.image = image
            }
            .store(in: &cancel)
    }
}
