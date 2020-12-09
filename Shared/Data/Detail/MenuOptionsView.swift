//
//  MenuOptionsView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/8.
//

import SwiftUI
import Request

struct MenuOptionsView: View {
    @State var sizeSelection : Int
    @State var milkSelection: Int
    @State var loading = false
    @Binding var showMore : Bool
    @Binding var showDetail : Bool
    let menu: DrinkMenu
    
    @EnvironmentObject var store : Store
    func createOrder()  {
        loading = true
        
        var newOrder = Order()
        newOrder.menu_id = menu.id
        newOrder.menu_name = menu.name
        newOrder.size = sizeSelection.description
        newOrder.price = menu.price
        newOrder.quantity = 1
        newOrder.imgUrl = menu.image[0].formats["thumbnail"]!.url
        newOrder.status = 0
        if !menu.milk.isEmpty {
            newOrder.milk_option = menu.milk[milkSelection].name
        }
        
        Request {
            Url(Network.createOrder)
            Method(.post)
            Header.ContentType(.json)
            RequestBody(newOrder)
        }
        .onJson { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {

                withAnimation {
                    loading = false
                    store.currentOrder = newOrder
                    store.action = .add //订单增加的全局通知
                    showDetail.toggle()
                }
                
            }
            
            
        }
        .onError { (error) in
            print("Error create：",error)
            withAnimation {
                loading = false
            }
        }
        .call()
    }
    
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 42, height: 6)
                    .opacity(0.3)
                    .padding(.top, 16)
                    .offset(y: 50)
                
                VStack(alignment: .center) {
                    MenuTitle(name: menu.name)
                    if !showMore {
                        PriceLabel(price: menu.price)
                            .transition(.asymmetric(insertion: .slide, removal: .opacity))
                    }
                }.padding()
                .offset(y: 50)
                
                if showMore {
                    VStack(alignment: .leading) {
                        Text("杯型")
                            .font(.system(size: 24))
                            .foregroundColor(Color(.secondaryLabel))
                        
                        SizeOptionsView(selection: $sizeSelection)
                    }
                    .padding()
                    .transition(.slide)
                    .animation(.spring())
                    
                    if !menu.milk.isEmpty {
                        VStack(alignment: .leading) {
                            Text("选配")
                                .font(.system(size: 24))
                                .foregroundColor(Color(.secondaryLabel))
                            MilkOptionView(selection: $milkSelection, options: menu.milk)
                        }
                        .padding()
                        .transition(.slide)
                        .animation(.spring())
                    }
                }
                if loading {
                    LoadingView()
                }
                AddToBagButton().onTapGesture {
                    impact(style: .medium)
                    createOrder()
                }.offset(y: 10)
            }
            .background(Blur(style: .systemMaterial))
            .cornerRadius(30)
            .shadow(color: .clear, radius: 2, x: 0, y: 1)
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
        .offset(y: -10)
        .gesture(
            DragGesture()
                .onEnded({ (value) in
                    if (abs(value.translation.height) > 10) {
                        withAnimation(Animation.spring()) {
                            showMore.toggle()
                        }
                    }
                })
        )
    }
}

struct MenuOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        MenuOptionsView(sizeSelection: 0, milkSelection: 1, showMore: .constant(true), showDetail: .constant(true), menu: drinksData[1].menus[0])
    }
}
