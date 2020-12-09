//
//  SideBar.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/7.
//

import SwiftUI
import Request

struct SideBar: View {
    @State var collapsed = false
    @State private var selection = 0
    @EnvironmentObject var store : Store
    
    var body: some View {
        ZStack {
            Color("maskOverlay")
                .offset(x: collapsed ? 0: -200)
                .opacity(collapsed ? 1 : 0)
                .animation(.easeOut)
                .transition(.opacity)
                .onTapGesture {
                    collapsed.toggle()
                }
            //订单侧边栏
            HStack(alignment: .bottom, spacing: -3) {
                ZStack(alignment: .top) {
                    LinearGradient(gradient: Gradient(colors: [Color("gradientStart"), Color("gradientEnd")]), startPoint: .leading, endPoint: .trailing)
                        .frame(width: 200, height: UIScreen.main.bounds.height)
                      
                    if !store.unpaidOrders.isEmpty && collapsed {
                        OrderListView(orders: $store.unpaidOrders, showPay: $store.showPay, selection: $selection)
                    }
                }
                ZStack {
                    Image("green_slide")
        //                .renderingMode(.template)
                        .frame(width: 57)
                        .offset(y: -30)
                        .foregroundColor(Color("gradientEnd"))
                        .onTapGesture {
                            collapsed.toggle()
                            if !collapsed {return}
                            store.getUnpaidOrders()
                    }
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundColor(.white)
                        .rotationEffect(collapsed ? .degrees(180) : .zero)
                        .offset(y: 95)
                }
                Spacer()
                
            }
            .offset(x: collapsed ? 0 : -200)
            .animation(.easeOut)
            .edgesIgnoringSafeArea(.all)
            .gesture(
            DragGesture()
                .onEnded({ (value) in
                    if (abs(value.translation.width) > 10) {
                        withAnimation() {
                            collapsed.toggle()
                            if !collapsed { return}
                            store.getUnpaidOrders()
                        }
                    }
                })
            )
            //支付view
            if store.showPay {
                Group {
                    Color("maskOverlay")
                        .onTapGesture {
                            withAnimation {
                                store.showPay.toggle()
                            }
                    }
                    VStack {
                        Spacer()
                        PayView(paySelection: 0, showPay: $store.showPay)
                    }.padding(.bottom, 20)
                }
                .transition(bottomUpTransition)
                .animation(.spring())
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onReceive(store.$collapse) {    //收到全局展开指令
            if $0 { //展开，获取订单
                collapsed = true

                store.getUnpaidOrders()
            } else {//关闭
                collapsed = false
            }
        }
        
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SideBar()
            .environmentObject(Store())
    }
}

var bottomUpTransition: AnyTransition {
    let insertion = AnyTransition.move(edge: .bottom)
        .combined(with: .opacity)
    let removal = AnyTransition.move(edge: .bottom)
        .combined(with: .opacity)
    return .asymmetric(insertion: insertion, removal: removal)
}
