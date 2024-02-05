//
//  SearchBarView.swift
//  Crypto-Currency
//
//  Created by Omar on 05/02/2024.
//

import SwiftUI

struct SearchBarView: View {
    
    //MARK: Properties
    @Binding var text: String
    
    init(text: Binding<String>) {
        self._text = text
    }
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(text.isEmpty ?
                                 Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by name...", text: $text)
                .foregroundColor(.theme.accent)
                .autocorrectionDisabled()
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.theme.accent)
                        .padding()
                        .offset(x: 10, y: 0)
                        .opacity(text.isEmpty ? 0.0 : 1.0)
                        .background()
                        .onTapGesture {
                            text = ""
                            UIApplication.shared.dismissKeyBoard()
                        }
                }
        }
        .font(.headline)
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.theme.background)
            .shadow(color: .theme.accent.opacity(0.15), radius: 10)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(text: .constant(""))
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            
            SearchBarView(text: .constant(""))
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
        }
    }
}
