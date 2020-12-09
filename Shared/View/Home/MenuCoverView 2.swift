//
//  MenuCoverView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/5.
//

import SwiftUI
import SDWebImageSwiftUI

struct MenuCoverView: View {
    let imgUrl: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 270, height: 340)
                .foregroundColor(Color("coverMask"))
            WebImage(url: URL(string: baseUrl + imgUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 230)
        }
        
            
    }
}

struct MenuCoverView_Previews: PreviewProvider {
    static var previews: some View {
        MenuCoverView(imgUrl: drinksData[0].menus[0].image[0].url)
    }
}
