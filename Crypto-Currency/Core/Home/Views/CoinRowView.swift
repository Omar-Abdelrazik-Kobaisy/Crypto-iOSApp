//
//  CoinRowView.swift
//  Crypto-Currency
//
//  Created by Omar on 09/01/2024.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    var body: some View {
        HStack{
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
            Circle()
                .frame(width:30,height: 30)
            Text((coin.symbol ?? "noSymbol").uppercased())
                .font(.headline)
                .foregroundColor(.theme.accent)
            Spacer()
            VStack(alignment: .trailing){
                Text((coin.currentPrice ?? 0.00).toCurrencyFormate6())
                    .bold()
                    .foregroundColor(.theme.accent)
                Text((coin.priceChangePercentage24H ?? 0).toCurrencyFormate6())
                    .foregroundColor(
                        coin.priceChangePercentage24H ?? 0 >= 0 ?
                            .theme.green : .theme.red
                    )
            }
        }
        .padding(.horizontal)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
    }
}
