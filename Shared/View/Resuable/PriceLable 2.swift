//
//  PriceTable.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/4.
//

import SwiftUI

struct PriceLable: View {
    @Environment(\.locale) var locale
    var price = 0.0
    var body: some View {
        HStack {
            Group {
                Text(locale.currencySymbol!)
                    .fontWeight(.semibold)
                Text(String(format: "%.2f", price))
                    .fontWeight(.semibold)
            }
            .font(.system(size: 32))
            .foregroundColor(Color("SubText"))
            
        }
        
            
    }
}

struct PriceTable_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PriceLable(price: drinksData[0].menus[0].price)
            PriceLable()
                .environment(\.locale, .init(identifier:"zh_cn"))
        }
    }
}
