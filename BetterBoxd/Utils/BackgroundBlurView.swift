//
//  BackgroundBlurView.swift
//  BetterBoxd
//
//  Created by Shiina on 5/30/24.
//

import SwiftUI

struct BackgroundBlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

