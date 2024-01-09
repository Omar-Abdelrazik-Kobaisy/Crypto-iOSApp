//
//  CoinRowView.swift
//  Crypto-Currency
//
//  Created by Omar on 09/01/2024.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool
    var body: some View {
        HStack{
            leftColumn
            Spacer()
            if showHoldingsColumn{
                centerCoulmn
            }
            rightCoulmn
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

extension CoinRowView{
    
    private var leftColumn: some View{
        HStack{
            Text("\(coin.rank)")
                .font(.headline)
                .foregroundColor(.theme.secondaryText)
            Circle()
                .frame(width:30,height: 30)
            Text((coin.symbol ?? "noSymbol").uppercased())
                .font(.headline)
                .foregroundColor(.theme.accent)
        }
    }
    
    private var centerCoulmn: some View{
            VStack(alignment:.trailing){
                Text(coin.currentHoldingPrice.toCurrencyFormate2())
                    .bold()
                Text(coin.currentHoldings?.asNumberString() ?? "0.00")
            }
            .foregroundColor(.theme.accent)
    }
    
    private var rightCoulmn: some View{
        VStack(alignment: .trailing){
            Text((coin.currentPrice ?? 0.00).toCurrencyFormate6())
                .bold()
                .foregroundColor(.theme.accent)
            Text((coin.priceChangePercentage24H ?? 0).asPercentString())
                .foregroundColor(
                    coin.priceChangePercentage24H ?? 0 >= 0 ?
                        .theme.green : .theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
