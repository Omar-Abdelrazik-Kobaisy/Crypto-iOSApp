//
//  CoinImageView.swift
//  Crypto-Currency
//
//  Created by Omar on 21/01/2024.
//

import SwiftUI


struct CoinImageView: View {
    @StateObject private var vm: CoinImageViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        if let image = vm.image{
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }else if vm.isLoading{
            ProgressView()
        }else{
            Image(systemName: "questionmark")
                .font(.system(.largeTitle))
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}
