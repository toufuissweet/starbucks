//
//  HomeView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/6.
//

import SwiftUI
import Request

struct HomeView: View {
    
    @State var drinks: [Drink] = []
    @State var loading = false
    @State var drinkSelect = 0
    @State var showDetail = false
    @State var menuSelects: [Int] = []
    
    @EnvironmentObject  var store : Store
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            VStack {
                Text("饮品")
                    .font(.system(size: 32))
                    .foregroundColor(.accentColor)
                HStack{
                    if drinks.isEmpty && loading {
                        SuccessView()
                    }
                }
                
                if !drinks.isEmpty {
                    DrinkListView(drinks: drinks, selection: $drinkSelect)
                    
                    ForEach(drinks.indices) { (index) in
                        if drinkSelect == index {
                            Group {
                                MenuListView(menus: drinks[index].menus, selection: $menuSelects[index])
                                MenuTitleView(menu: drinks[index].menus[menuSelects[index]])
                            }
                            .onTapGesture {
                                withAnimation {
                                    showDetail.toggle()
                                }
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 40)
            .padding(.leading, 10)
            
            if showDetail {
                DetailView(menu: drinks[drinkSelect].menus[menuSelects[drinkSelect]], showMore: false, showDetail: $showDetail)
            }
            SideBar()
                .offset(x: drinks.isEmpty ? -100: 0)
                .zIndex(2)
            
            switch store.action {
            case .add:
                OrderHUD(text: "已下单，等待支付")
                    .padding(.bottom, 30)
                    .padding(.trailing, 30)
            case .pay:
                OrderHUD(text: "已支付，配送中")
                    .padding(.bottom, 30)
                    .padding(.trailing, 30)
                
            default:
                BagButton()
                    .foregroundColor(.accentColor)
                    .padding(.bottom, 50)
                    .padding(.trailing, 30)
                    .offset(x: drinks.isEmpty ? 300 : 0)
                    .onTapGesture {
                        impact(style: .light)
                        store.collapse.toggle()
                    }
            }
        }
        .onAppear{
            getDataFromNetwork()
        }
    }
    
    func getDataFromNetwork()  {
        loading = true
        AnyRequest<[Drink]> {
            Url(Network.findDrinks)
        }
        .onObject({ (drinks) in
            withAnimation {
                //保存每个类别下，菜单的序号
                self.menuSelects = Array(repeating: 0, count: drinks.count)
                
                self.drinks = drinks
                
                loading = false
            }
        })
        .call()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Store())
            .environment(\.locale, .init(identifier:"zh_cn"))
    }
}
