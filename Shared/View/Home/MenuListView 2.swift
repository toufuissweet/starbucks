//
//  MenuListView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/5.
//

import SwiftUI

struct MenuListView: View {
    var menus : [DrinkMenu]
    @Binding var selection: Int
    @State private var offset : CGFloat = 0
    let swipeWidth: CGFloat = 250
    let swipeHeight: CGFloat = 404
    
    var body: some View {
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 10){
                        if !menus.isEmpty{
                            ForEach(menus.indices) { index in
                                MenuCoverView(imgUrl: menus[index].image[0].url)
                                    .frame(width: swipeWidth, height: swipeHeight)
                                    .scaleEffect(selection == index ? 1 : 0.8)
                                    .animation(.easeOut)
                                    .transition(.slide)
                            }
                        }
                    }
                }
                .content.offset(x: offset)
                .frame(width: swipeWidth, alignment: .leading)
                .onAppear{
                    offset -= swipeWidth * CGFloat(selection)
                }
                .gesture(
                    DragGesture()
                        .onChanged({ (value) in
                            offset = value.translation.width - swipeWidth * CGFloat(selection)
                        })
                        .onEnded({ (value) in
                            if -value.predictedEndTranslation.width > swipeWidth / 2, selection < menus.count - 1{
                                withAnimation(.easeOut) {
                                    selection += 1
                                }
                            }
                            if value.predictedEndTranslation.width > swipeWidth / 2, selection > 0 {
                                withAnimation(.easeOut) {
                                    selection -= 1
                                }
                            }
                            withAnimation(.easeOut) {// Let the HStack move
                                offset = -(swipeWidth + 10) * CGFloat(selection)
                            }
                        })
                )
            }
        
    }
}

struct SwipeView_Previews: PreviewProvider {
    struct testSwipeView1 : View {
        @State  private var selection = 1

        var body: some View {
            VStack {
                MenuListView(menus: drinksData[0].menus, selection: $selection)
                Text(selection.description)
            }
        }
    }

    static var previews: some View {
        testSwipeView1()
    }
}
