//
//  SizeOptionsView.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/4.
//

import SwiftUI

enum Size: CaseIterable {
    case M,L,XL
    
    var desc: [String] {
        switch self {
        case .M:
            return ["m-cup","中杯"]
        case .L:
            return ["l-cup","大杯"]
        case .XL:
            return ["xl-cup","超大杯"]
        }
    }
    
}

struct SizeOptionsView: View {
    @Binding var selection: Int
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(Size.allCases.indices) { item in
                VStack{
                    Image(Size.allCases[item].desc.first!)
                        .renderingMode(.template)
                    Text(Size.allCases[item].desc[1])
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .onTapGesture {
                    selection = item
                }
                .foregroundColor(selection == item ? Color.accentColor : Color("Unselect"))
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.separator))
        )
        .padding()
    }
}

struct SizeOptionsView_Previews: PreviewProvider {
    //新建一个上级View 测试此View互动性是否正确
    struct testView1: View {
        @State var selection: Int
        
        var body: some View {
            SizeOptionsView(selection: $selection)
            
        }
    }
    
    static var previews: some View {
        
        Group {
            testView1(selection: 2)
                .preferredColorScheme(.dark)
            SizeOptionsView(selection: .constant(0))
        }
    }
}
