//
//  haptic+impact.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/9.
//

import SwiftUI

func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
}
//震动强度
func impact(style:  UIImpactFeedbackGenerator.FeedbackStyle) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}
