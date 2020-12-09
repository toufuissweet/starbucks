//
//  PayButton.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/8.
//

import SwiftUI

struct PayButton: View {
    var body: some View {
        HStack {
            Image(systemName: "creditcard.fill")
                .font(.system(size: 35))
                .frame(width: 80, height: 48)
            Text("支付")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .frame(minWidth: 80)
        }
        .padding(8)
        .overlay(
        RoundedRectangle(cornerRadius: 32)
            .stroke(lineWidth: 1)
            .foregroundColor(Color(.opaqueSeparator))
        )
        .foregroundColor(.accentColor)
    }
}

struct PayButton_Previews: PreviewProvider {
    static var previews: some View {
        PayButton()
            .preferredColorScheme(.dark)
            .environment(\.locale, .init(identifier:"zh"))
    }
}
