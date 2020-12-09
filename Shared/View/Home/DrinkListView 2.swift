//
//  DrinkListView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/5.
//

import SwiftUI

struct DrinkListView: View {
    let drinks: [Drink]
    @Binding var selection: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 42.0) {
                ForEach(drinks.indices) { item in
                    DrinkView(drink: drinks[item])
                        .foregroundColor(selection == item ? Color.accentColor : Color("Unselect"))
                        .scaleEffect(selection == item ? 1.1 : 1)
                        .onTapGesture {
                            withAnimation(Animation.interactiveSpring()){
                                selection = item
                            }
                        }
                        
                }.frame(height: 111)
                .padding([.leading, .bottom], 15)
            }
        }
        
    }
}

struct DrinkListView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkListView(drinks: drinksData, selection: .constant(1))
            .preferredColorScheme(.dark)
    }
}
