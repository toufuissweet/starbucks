//
//  PayChoiceView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/8.
//

import SwiftUI

enum Vendor: CaseIterable {
    case applepay, wepay, alipay
    
    var desc: [String] {
        switch self {
        case .applepay:
            return ["applepay", "Apple Pay"]
        case .wepay:
            return ["wepay", "Wechat"]
        case .alipay:
            return ["alipay", "Alipay"]
        }
    }
}

struct PayChoiceView: View {
    @Binding var selection: Int
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(Vendor.allCases.indices) { item in
                VStack {
                    Image(Vendor.allCases[item].desc.first!)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                    Text(LocalizedStringKey(Vendor.allCases[item].desc[1]))
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity)
                    
                }
                .padding()
                .onTapGesture {
                    selection = item
                }
                .foregroundColor(selection == item ? Color.accentColor : Color("Unselect"))
            }
            .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.separator))
            )
        }
    }
}

struct PayChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        PayChoiceView(selection: .constant(1))
    }
}
