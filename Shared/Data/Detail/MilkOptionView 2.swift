//
//  MilkOptionView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/8.
//

import SwiftUI

struct MilkOptionView: View {
    @Binding var selection: Int
    var options : [MilkOption]
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(options.indices) { item in
                HStack {
                    Image(systemName: selection == item ? "checkmark.square.fill" : "square")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .foregroundColor(selection == item ? Color.accentColor : Color("Unselect"))
                    Text(LocalizedStringKey(options[item].name))
                        .font(.system(size: 20))
                        .foregroundColor(Color.accentColor)
                    Spacer()
                }
                .padding()
                .onTapGesture {
                    selection = item
                }
                if (item != options.count - 1){
                    Divider()
                        .padding(.horizontal)
                }
            }
        }.overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.separator))
        )
    }
}

struct MilkOptionView_Previews: PreviewProvider {
    static var previews: some View {
        MilkOptionView(selection: .constant(1), options: drinksData[1].menus[1].milk)
    }
}
