//
//  LottieView.swift
//  Pokedex
//
//  Created by Bundit Thakummee on 16/2/2566 BE.
//

import SwiftUI
import Lottie
 
struct LottieView: UIViewRepresentable {
    let lottieFile: String
    var loopMode: LottieLoopMode = .playOnce
 
    let animationView = LottieAnimationView()
 
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
 
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()

        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
 
    func updateUIView(_ uiView: UIViewType, context: Context) {
 
    }
}
