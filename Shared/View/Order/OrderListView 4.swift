//
//  OrderListView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/7.
//

import SwiftUI
import Request

struct OrderListView: View {
    @Binding var orders: [Order]
    @Binding var showPay : Bool
    @Binding var selection : Int
    @EnvironmentObject var status: Store
    
    func deleteOrder(id: Int) {
        AnyRequest<Order> {
            Url(Network.deleteOrder + id.description)
            Method(.delete)
        }
        .onObject({ _ in
            DispatchQueue.main.async {
                debugPrint("服务器删除成功！")
                status.action = .delete
            }
        })
        .call()
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 40) {
                Image("bag")
                    .renderingMode(.template)
                    .resizable()
                    .scaleEffect()
                    .frame(width: 40)
                
                if !orders.isEmpty {
                    ForEach(orders.indices, id: \.self) { index in
                        LazyVStack() {
                            //将未支付的订单删除
                            if orders[index].status == 0 {
                                HStack {
                                    Button(action: {
                                        deleteOrder(id: orders[index].id)
                                        orders.remove(at: index)
                                    }, label: {
                                        Image(systemName: "minus.circle")
                                            .font(.system(size: 25))
                                })
                                    Spacer()
                                }
                                .offset(x: 15, y: 50)
                                .zIndex(1)
                            }
                            OrderCoverView(imgUrl: orders[index].imgUrl)
                            
                            //未支付状态，显示支付小图标
                            if orders[index].status == 0 {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        showPay.toggle()
                                        status.currentOrder = orders[index]
                                    }, label: {
                                        Image(systemName: "creditcard.fill")
                                            .font(.system(size: 30))
                                    })
                                }
                                .offset(x: -15, y: -30)
                            }
                            
                            Text(orders[index].menu_name)
                                .font(.system(size: 24))
                                .frame(maxWidth: 170,maxHeight: .infinity)
                        }
                    }
                }
            }
        }
        .padding(.top, 40)
        .foregroundColor(.white)
        .frame(width: 190)
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView(orders: .constant(ordersData), showPay: .constant(false), selection: .constant(0))
            .preferredColorScheme(.dark)
    }
}
