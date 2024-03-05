//
//  ProfileMainStatsView.swift
//  Soccer
//
//  Created by Виталий Загороднов on 27.04.2023.
//

import UIKit

class ProfileMainStatsView: UIView {
    private lazy var valueLabel = makeLabel()
    private lazy var subtitleLabel = makeLabel()
    
    private lazy var valueAttrs = TextAttributes()
        .font(Fonts.Inter.bold(size: 50.scale))
        .lineHeight(60.scale)
        .textColor(Appearance.secondary)
        .textAlignment(.center)
    
    private lazy var subtitleAttrs = TextAttributes()
        .font(Fonts.Inter.regular(size: 16.scale))
        .lineHeight(25.6.scale)
        .textColor(Appearance.white)
        .textAlignment(.center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileMainStatsView {
    func setup(value: String, subtitle: String) {
        valueLabel.attributedText = value.attributed(with: valueAttrs)
        subtitleLabel.attributedText = subtitle.attributed(with: subtitleAttrs)
    }
}

// MARK: Private
private extension ProfileMainStatsView {
    func initialize() {
        backgroundColor = .clear
    }
}

// MARK: Make constraints
private extension ProfileMainStatsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: topAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 8.scale),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension ProfileMainStatsView {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
