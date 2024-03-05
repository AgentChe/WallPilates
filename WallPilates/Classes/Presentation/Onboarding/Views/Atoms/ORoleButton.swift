//
//  ORoleButton.swift
//  Soccer
//
//  Created by Андрей Чернышев on 01.02.2023.
//

import UIKit

final class ORoleButton: UIButton {
    var marked = false {
        didSet {
            update()
        }
    }
    
    let soccerRole: SoccerRole
    
    lazy var iconView = makeIconView()
    lazy var nameLabel = makeLabel()
    
    init(soccerRole: SoccerRole) {
        self.soccerRole = soccerRole
        
        super.init(frame: .zero)
        
        makeConstraints()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension ORoleButton {
    func update() {
        backgroundColor = marked ? Appearance.secondary : Appearance.white.withAlphaComponent(0.1)
        layer.borderWidth = marked ? 0 : 1.scale
        layer.borderColor = marked ? UIColor.clear.cgColor : Appearance.white.withAlphaComponent(0.1).cgColor
        
        iconView.image = icon
        
        let attrs = TextAttributes()
            .textColor(Appearance.white.withAlphaComponent(marked ? 1 : 0.7))
            .font(Fonts.Inter.regular(size: 16.scale))
            .lineHeight(25.6.scale)
            .textAlignment(.center)
        nameLabel.attributedText = name.attributed(with: attrs)
    }
    
    var icon: UIImage? {
        switch soccerRole {
        case .player:
            return UIImage(named: marked ? "Onboarding.Role.Player.Selected" : "Onboarding.Role.Player.Deselected")
        case .coach:
            return UIImage(named: marked ? "Onboarding.Role.Coach.Selected" : "Onboarding.Role.Coach.Deselected")
        case .amateur:
            return UIImage(named: marked ? "Onboarding.Role.Amateur.Selected" : "Onboarding.Role.Amateur.Deselected")
        }
    }
    
    var name: String {
        switch soccerRole {
        case .player:
            return "Onboarding.Role.Player".localized
        case .coach:
            return "Onboarding.Role.Coach".localized
        case .amateur:
            return "Onboarding.Role.Amateur".localized
        }
    }
}

// MARK: Make constraints
private extension ORoleButton {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6.scale),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension ORoleButton {
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
