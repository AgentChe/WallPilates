//
//  OPositionButton.swift
//  Soccer
//
//  Created by Андрей Чернышев on 03.02.2023.
//

import UIKit

final class OPositionButton: UIButton {
    lazy var marked = false {
        didSet {
            update()
        }
    }
    
    lazy var label = makeLabel()
    
    let text: String
    
    init(text: String) {
        self.text = text
        
        super.init(frame: .zero)
        
        makeConstraints()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = max(frame.width, frame.height) / 2
    }
}

// MARK: Private
private extension OPositionButton {
    func update() {
        layer.borderWidth = marked ? 0 : 1.scale
        layer.borderColor = marked ? UIColor.clear.cgColor : Appearance.white.withAlphaComponent(0.1).cgColor
        
        backgroundColor = marked ? Appearance.primary : Appearance.black
    }
}

// MARK: Make constraints
private extension OPositionButton {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OPositionButton {
    func makeLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.white)
            .font(Fonts.Inter.semiBold(size: 14.scale))
            .lineHeight(19.6.scale)
            .letterSpacing(-0.44.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = text.localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
