//
//  DetailView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/8.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    let menu : DrinkMenu
    @State var showMore = false
    @Binding var showDetail: Bool
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                WebImage(url: URL(string: baseUrl + menu.image[0].url))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 510)
                    .padding(.top, 30)
                Spacer()
            }
            ZStack(alignment: Alignment.init(horizontal: .leading, vertical: .top)){
                Color("maskOverlay")
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.vertical, 55)
                    .padding(.horizontal, 30)
                    .onTapGesture {
                        impact(style: .light)
                        withAnimation {
                            showDetail.toggle()
                        }
                    }
            }
            MenuOptionsView(sizeSelection: 0, milkSelection: 0, showMore: $showMore, showDetail: $showDetail, menu: menu)
        }.edgesIgnoringSafeArea(.all)
        .background(Blur(style: .systemChromeMaterial))
        .transition(pushTransition)
        .animation(.spring())
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(menu: drinksData[1].menus[0], showDetail: .constant(true))
            .environment(\.locale, .init(identifier:"zh_cn"))
    }
}

var pushTransition: AnyTransition {
    let insertion = AnyTransition.move(edge: .trailing)
        .combined(with: .opacity)
    let removal = AnyTransition.move(edge: .trailing)
        .combined(with: .opacity)
    return .asymmetric(insertion: insertion, removal: removal)
}
