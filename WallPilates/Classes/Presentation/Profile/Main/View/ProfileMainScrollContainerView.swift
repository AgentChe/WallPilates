//
//  ProfileMainScrollContainerView.swift
//  Soccer
//
//  Created by Виталий Загороднов on 28.04.2023.
//

import UIKit

class ProfileMainScrollContainerView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let color = Appearance.background
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color.cgColor, color.cgColor, UIColor.clear, UIColor.clear, color.cgColor, color.cgColor]
        gradientLayer.locations = [0, 0.1, 0.3, 0.7, 0.9, 1]
        gradientLayer.startPoint = .init(x: 0, y: 0.5)
        gradientLayer.endPoint = .init(x: 1, y: 0.5)
        gradientLayer.frame = rect
        layer.addSublayer(gradientLayer)
    }
}
