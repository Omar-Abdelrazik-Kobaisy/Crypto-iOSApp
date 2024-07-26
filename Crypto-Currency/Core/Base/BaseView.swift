//
//  BaseView.swift
//  Crypto-Currency
//
//  Created by Omar on 26/07/2024.
//

import SwiftUI

struct BaseView<Content: View>: View {
    var content: () -> Content
    var body: some View {
        ZStack {
            //MARK: 1- background Layer
            Color.theme.background
                .ignoresSafeArea()
            
            content()
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView(content:{
            Text("Hello World")
        })
    }
}
