//
//  HomeView.swift
//  Crypto-Currency
//
//  Created by Omar on 06/01/2024.
//

import SwiftUI

struct HomeView: View {
    //MARK: properties
    @State private var isShowingPortfolio: Bool = false
    @EnvironmentObject var vm: HomeViewModel
    var body: some View {
        ZStack{
            //MARK: background Layer
            Color.theme.background
                .ignoresSafeArea()
            //MARK: content Layer
            VStack{
                homeHeader
                columnTitle
                ScrollView{
                    if isShowingPortfolio{
                        AllCoinList(coins: vm.livePriceCoins,
                                    isShowingPortfolio: isShowingPortfolio)
                        .transition(.move(edge: .trailing))
                    }else{
                        AllCoinList(coins: vm.portfolioCoins,
                                    isShowingPortfolio: isShowingPortfolio)
                        .transition(.move(edge: .leading))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .toolbar(.hidden, for: .navigationBar)
        }
        .environmentObject(dev.vm)
    }
}



extension HomeView{
    private var homeHeader: some View{
            HStack {
                CircleButtonView(iconName: isShowingPortfolio ?"plus":"info")
                    .animation(.none, value: UUID())
                    .background(
                            CircleButtonAnimationView(animate: $isShowingPortfolio)
                    )
                Text(isShowingPortfolio ? "Portfolio" : "Live Prices")
                    .font(.system(.headline,weight: .heavy))
                    .foregroundColor(.theme.accent)
                    .frame(width: 220)
                    .animation(.none, value: UUID())
                CircleButtonView(iconName: "chevron.right")
                    .rotationEffect(.degrees(isShowingPortfolio ? 180 : 0))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isShowingPortfolio.toggle()
                        }
                    }
            }
            .padding(.horizontal)
    }
    private var columnTitle: some View{
            HStack{
                Text("Coin")
                    .frame(maxWidth: .infinity,alignment: .leading)
                if isShowingPortfolio{
                    Text("Holdings")
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                Text("Price")
            }
            .frame(maxWidth: .infinity)
            .font(.system(.body,design: .rounded,weight: .regular))
            .foregroundColor(.theme.secondaryText)
            .padding(.horizontal)
    }
}

