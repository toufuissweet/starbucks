//
//  PriceLabel.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/8.
//

import SwiftUI

struct PriceLabel: View {
//    @Environment(\.locale) var locale
    var price = 0.0
    var body: some View {
        HStack {
            Group{
                Text("¥")
                    .fontWeight(.semibold)
                Text(" " + String(format: "%.2f", price))
                    .fontWeight(.semibold)
            }
            .font(.system(size: 32))
            .foregroundColor(Color("SubText"))
        }
    }
}

struct PriceLabel_Previews: PreviewProvider {
    static var previews: some View {
        PriceLabel()
    }
}
