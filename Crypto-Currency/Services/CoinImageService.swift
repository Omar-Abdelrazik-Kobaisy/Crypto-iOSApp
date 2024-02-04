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
    private let coin: CoinModel
    private var networkManager: NetworkProtocol
    private let fileManager = LocalFileManager.instance
    private let folderName = "CoinImage"
    private var coinImageSubscription: AnyCancellable?
    init(networkManager: NetworkProtocol = NetworkManager(),
         coin: CoinModel){
        self.networkManager = networkManager
        self.coin = coin
        getImage()
    }
    private func getImage(){
        if let savedImage = fileManager.getImage(imageName: coin.id ?? "0", folderName: folderName)  {
            image = savedImage
            print("imageRetrieved from fileManager")
        }else{
            downloadCoinImage()
        }
    }
    private func downloadCoinImage(){
        guard let url = URL(string: coin.image ?? "") else{
            print("bad URL")
            return
        }
        
        coinImageSubscription = networkManager.download(fromURL: url)
            .tryMap({ output in
                return UIImage(data: output)
            })
            .sink(receiveCompletion: networkManager.handleCompletion(completion:), receiveValue: {[weak self] image in
                guard let self, let image else{return}
                self.image = image
                self.fileManager.saveImage(image: image ,
                                           imageName: self.coin.id ?? "0",
                                           folderName: self.folderName)
                self.coinImageSubscription?.cancel()
            })
    }
}
