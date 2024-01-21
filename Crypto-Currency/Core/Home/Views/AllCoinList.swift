//
//  AllCoinList.swift
//  Crypto-Currency
//
//  Created by Omar on 12/01/2024.
//

import SwiftUI

struct AllCoinList: View {
    //MARK: properties
    var coins: [CoinModel]
    var isShowingPortfolio: Bool
    
    var body: some View {
        VStack {
            ForEach(coins, content: {coin in
                CoinRowView(coin: coin,
                            showHoldingsColumn: isShowingPortfolio)
            })
        }
        .padding(.horizontal,5)
    }
}

struct AllCoinList_Previews: PreviewProvider {
    static var previews: some View {
        AllCoinList(coins: [dev.coin],
                    isShowingPortfolio: false)
    }
}
