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
    var body: some View {
        ZStack{
            //MARK: background Layer
            Color.theme.background
                .ignoresSafeArea()
            //MARK: content Layer
            VStack{
                homeHeader
                Spacer()
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
}
