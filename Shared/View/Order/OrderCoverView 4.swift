//
//  OrderCoverView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/7.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderCoverView: View {
    let imgUrl: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color("orderCoverMask"))
                .frame(width: 122, height: 137)
            WebImage(url: URL(string: baseUrl + imgUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 92)
        }
    }
}

struct OrderCoverView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCoverView(imgUrl: ordersData[0].imgUrl)
    }
}
