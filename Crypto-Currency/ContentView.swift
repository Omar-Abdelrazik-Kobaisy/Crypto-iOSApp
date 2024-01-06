//
//  ContentView.swift
//  Crypto-Currency
//
//  Created by Omar on 06/01/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 15){
                Text("Accent Color")
                    .foregroundColor(.theme.accent)
                Text("Secondary Color")
                    .foregroundColor(.theme.secondaryText)
                Text("Red Color")
                    .foregroundColor(.theme.red)
                Text("Green Color")
                    .foregroundColor(.theme.green)
            }
            .font(.largeTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
