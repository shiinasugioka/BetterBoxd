import SwiftUI
import UIKit

struct VisualEffectBlur: UIViewRepresentable {
    var effect: UIVisualEffect?
    var intensity: CGFloat

    init(effect: UIVisualEffect? = UIBlurEffect(style: .systemMaterial), intensity: CGFloat = 1) {
        self.effect = effect
        self.intensity = intensity
    }

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView()
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = nil
        let animator = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            uiView.effect = effect
        }
        animator.fractionComplete = intensity
        animator.startAnimation()
    }
}
