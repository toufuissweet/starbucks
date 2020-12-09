//
//  BagButton.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/9.
//

import SwiftUI

struct BagButton: View {
    @EnvironmentObject var store : Store
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            Image("bag")
                .renderingMode(.template)
                .frame(width: 74, height: 74)
                .overlay(
                RoundedRectangle(cornerRadius: 37)
                    .stroke(lineWidth: 3)
            )
            if store.unpaidOrders.count > 0 {
                ZStack {
                    Circle()
                        .frame(width: 25, height: 25)
                    Text(store.unpaidOrders.count < 100 ? "\(store.unpaidOrders.count)" : "99+")
                        .foregroundColor(Color(.systemBackground))
                }.offset(x: -8, y: 8)
            }
        }
        //不获取新订单
        .onReceive(store.$action){
            print($0)
            if $0 != .hudEnd {
                store.getUnpaidOrders()
            }
        }
    }
}

struct BagButton_Previews: PreviewProvider {
    static var previews: some View {
        BagButton()
            .environmentObject(Store())
    }
}
