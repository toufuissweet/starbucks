//
//  PayView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/7.
//

import SwiftUI
import Request

struct PayView: View {
    @State var paySelection : Int
    @State private var loading = false
    @GestureState var tap = false
    @Binding var showPay: Bool
    @State var successPay = false
    @EnvironmentObject var store : Store
    
    func updateOrder(id: Int) {
        loading = true
        
        var newOrder = store.currentOrder!
        newOrder.status = 1
        newOrder.payvender = paySelection.description
        
        AnyRequest<Order> {
            Url(Network.updateOrder + id.description)
            Method(.put)
            Header.ContentType(.json)
            RequestBody(newOrder)
        }
        .onObject { _ in //成功支付
            DispatchQueue.main.async{
                loading.toggle()
                successPay.toggle()
            }
            //等成功支付的2.5秒动画完毕后再更新状态
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                store.action = .pay //订单支付的全局通知
                store.collapse = false //关闭侧边栏
                showPay.toggle()
            }
        }
        .onError { (error) in
            print("Error update：",error)
            withAnimation {
                loading = false
            }
        }
        .call()
        
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.secondary)
                    .onTapGesture {
                        impact(style: .medium)
                        withAnimation{
                            showPay.toggle()
                        }
                    }
            }
            .padding(.top)
            .padding(.trailing)
            
            VStack(alignment: .center){
                MenuTitle(name: store.currentOrder!.menu_name)
                PriceLabel(price: store.currentOrder!.price)
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text("支付方式")
                    .font(.system(size: 24))
                    .foregroundColor(Color(.secondaryLabel))
                PayChoiceView(selection: $paySelection)
            }
            .padding()
            if loading {
                LoadingView()
            }
            if !successPay {
                PayButton()
                    .offset(x: -10, y: -10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 32)
                            .trim(from: tap ? 0.001 : 1, to: 1.0)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)), Color(#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                            .frame(width: 60, height: 180)
                            .rotationEffect(Angle(degrees: 90))
                            .rotation3DEffect(
                                Angle(degrees: 180),
                                axis: (x: 1.0, y: 0.0, z: 0.0)
                            )
                            .animation(.easeInOut)
                            .offset(x: -10, y: -10)
                    )
                    .scaleEffect(tap ? 1.2 : 1)
                    .gesture(
                    LongPressGesture()
                        .updating($tap) { currentState, gestureState, transaction in
                            gestureState = currentState
                            
                        }
                        .onEnded({ (value) in
                            haptic(type: .success)
                            updateOrder(id: store.currentOrder!.id)
                        })
                    )
            }else{
                PaySuccessView()
            }
//                Button(action: {
//                    updateOrder(id: store.currentOrder!.id)
//                }, label: {
//                    PayButton()
//                })
//                .padding()
//            }else {
//                PaySuccessView()
//            }
        }
        .background(Blur(style: .systemChromeMaterial))
        .cornerRadius(30)
        .shadow(color: .clear, radius: 2, x: 0, y: 1)
    }
}

struct PayView_Previews: PreviewProvider {
    struct testView1: View {
        @State var sel1: Int
        @State var showPay = false
        @StateObject var store: Store = {
            let _store = Store()
            _store.currentOrder = ordersData[0]
            return _store
        }()
        var body: some View {
            PayView(paySelection: sel1, showPay: $showPay)
                .environmentObject(store)
        }
    }
    
    static var previews: some View {
        testView1(sel1: 0)
//            .preferredColorScheme(.dark)
            .environment(\.locale, .init(identifier:"zh_cn"))
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
