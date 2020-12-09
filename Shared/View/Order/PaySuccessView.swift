//
//  PaySuccessView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/8.
//

import SwiftUI

struct PaySuccessView: View {
    @State var rotateBlueCircle = false
    @State var scaleUpGreenCircle = false
    @State var showCheckMark = false
    var body: some View {
        ZStack{
            Circle()
                .trim(from: 1/20, to: 1)
                .stroke(Color.blue,lineWidth: 4)
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(rotateBlueCircle ? 0 : -1440))
                .animation(Animation.easeIn(duration: 2))
                .onAppear{
                    rotateBlueCircle.toggle()
                }
            Circle()
                .frame(width: 54, height: 54)
                .foregroundColor(.green)
                .scaleEffect(scaleUpGreenCircle ? 1 : 0)
                .animation(Animation.easeIn(duration: 2))
                .onAppear {
                    scaleUpGreenCircle.toggle()
                }
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .scaleEffect(showCheckMark ? 1 : 0)
                .font(.system(size: 30))
                .animation(Animation.easeIn(duration: 0.3).delay(2 - 0.3)
                )
                .onAppear{
                    showCheckMark.toggle()
                }
        }.padding()
    }
}

struct PaySuccessView_Previews: PreviewProvider {
    static var previews: some View {
        PaySuccessView()
    }
}
