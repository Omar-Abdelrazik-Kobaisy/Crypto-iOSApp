//
//  CircleButtonAnimationView.swift
//  Crypto-Currency
//
//  Created by Omar on 06/01/2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    //MARK: properties
    @Binding var animate: Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? .easeOut(duration: 0.7) : .none, value: UUID())
        
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(false))
    }
}
