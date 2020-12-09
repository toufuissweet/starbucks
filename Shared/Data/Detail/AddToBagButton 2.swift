//
//  AddToBagButton.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/8.
//

import SwiftUI

struct AddToBagButton: View {
    var body: some View {
        HStack {
            ZStack {
                Circle().frame(width: 48, height: 48)
                Image(systemName: "plus")
                    .font(.system(size: 23))
                    .foregroundColor(.white)
            }
            Text("加到购物袋")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .frame(width: 150)
        }
        .frame(width: .infinity, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.opaqueSeparator))
        )
        .foregroundColor(.accentColor)
        .padding()
    }
}

struct AddToBagButton_Previews: PreviewProvider {
    static var previews: some View {
        AddToBagButton()
            .environment(\.locale, .init(identifier: "zh"))
    }
}
