//
//  OrderHUD.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/8.
//

import SwiftUI

struct OrderHUD: View {
    @State var text = ""
    @EnvironmentObject var store : Store
    
    var transition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    var body: some View {
        HStack {
            OrderThumbView(imgUrl: store.currentOrder?.imgUrl ?? "")
            Text(LocalizedStringKey(text))
                .font(.system(size: 22))
                .fontWeight(.semibold)
            
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                Image("bag")
                    .renderingMode(.template)
                    .frame(width: 74, height: 74)
            }
        }
        .foregroundColor(Color("AccentColor"))
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 56)
                .foregroundColor(Color(.tertiarySystemBackground))
                .shadow(color: Color("AccentColor"), radius: 5)
        )
        .onAppear{
            //指定时间内自动消失
            let dispatchWorkHolder = DispatchWorkHolder()
            dispatchWorkHolder.work?.cancel()
            dispatchWorkHolder.work = DispatchWorkItem(block: {
                withAnimation{
                    store.action = .hudEnd
                }
            })
            //status.action != .hudEnd
            if let work = dispatchWorkHolder.work {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: work)
            }
        }
        .transition(transition)
    }
}


class DispatchWorkHolder {
    var work: DispatchWorkItem?
}


struct OrderHUD_Previews: PreviewProvider {
    struct testView: View {
        @State var text = ""
        @StateObject var store: Store = {
            let _status1 = Store()
            _status1.currentOrder = ordersData[0]
            return _status1
        }()
        
        var body: some View {
            OrderHUD(text: text)
                .environmentObject(store)
        }
    }
    static var previews: some View {
        testView(text: "已下单，等待支付")
    }
}
