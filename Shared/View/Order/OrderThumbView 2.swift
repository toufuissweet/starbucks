//
//  OrderThumbView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/8.
//

import SwiftUI
import  SDWebImageSwiftUI


struct OrderThumbView: View {
    let imgUrl : String
    
    var body: some View {
        ZStack() {
            Circle()
                .frame(width: 2 * 34)
                
            WebImage(url: URL(string: baseUrl + imgUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 1.5 * 34)
        }
        .frame(width: 2 * 34, height: 3 * 34)
        .clipShape(HalfCapsule())
    }
}

struct OrderThumbView_Previews: PreviewProvider {
    static var previews: some View {
        OrderThumbView(imgUrl: ordersData[0].imgUrl)
    }
}
struct HalfCapsule: Shape {
    func path(in rect: CGRect) -> Path {
      
        let leftMiddle = CGPoint(x: 0, y: rect.midY)
        let rightMiddle = CGPoint(x: rect.maxX, y: rect.midY)
        let rightCorner = CGPoint(x: rect.maxX, y: 0)
        let center = CGPoint(x: rect.midX, y: rect.midY)

        return Path {
            $0.move(to: leftMiddle)
            $0.addLine(to: .zero)
            $0.addLine(to: rightCorner)
            $0.addLine(to: rightMiddle)
            
            $0.addArc(center: center, radius: 34, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: true)
            
        }
    }
}
