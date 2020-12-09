//
//  MenuTitleView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/4.
//

import SwiftUI

struct MenuTitleView: View {
    var menu : DrinkMenu
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("现在下单")
                    .fontWeight(.semibold)
                    .font(.system(size: 21))
                    .foregroundColor(Color("SubText"))
                Image("arrow")
            }
            
            Text(menu.name.description)
                .font(.system(size: 32))
                .foregroundColor(.accentColor)
                .fontWeight(.heavy)
                .lineLimit(2)
            Spacer()
            PriceLable(price: menu.price)
        }
        .padding(10)
        .frame(width: 280, height: 200)
    }
}

struct MenuTitleView_Previews: PreviewProvider {
    static var previews: some View {
        MenuTitleView(menu: drinksData[0].menus[0])
            
    }
}
