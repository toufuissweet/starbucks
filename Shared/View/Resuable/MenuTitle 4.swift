//
//  MenuTitle.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/8.
//

import SwiftUI

struct MenuTitle: View {
    var name = ""
    
    var body: some View {
        Text(name)
            .font(.system(size: 36))
            .foregroundColor(.accentColor)
            .lineLimit(2)
            .frame(maxWidth: .infinity, minHeight: 125)
    }
}

struct MenuTitle_Previews: PreviewProvider {
    static var previews: some View {
        MenuTitle()
    }
}
