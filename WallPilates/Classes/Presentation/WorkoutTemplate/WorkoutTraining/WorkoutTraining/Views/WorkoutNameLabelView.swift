//
//  WorkoutNameLabelView.swift
//  Soccer
//
//  Created by Виталий Загороднов on 25.03.2023.
//

import UIKit

class WorkoutNameLabelView: UIView {
    private lazy var nameLabel = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        makeConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: Public
extension WorkoutNameLabelView {
    func setup(name: String) {
        let attrs = TextAttributes()
            .textColor(Appearance.white)
            .font(Fonts.Inter.semiBold(size: 16.scale))
            .lineHeight(25.scale)
            .textAlignment(.center)
        
        nameLabel.attributedText = name.attributed(with: attrs)
    }
}

// MARK: Private
private extension WorkoutNameLabelView {
    func initialize() {
        backgroundColor = Appearance.black
        layer.cornerRadius = 10.scale
        layer.borderWidth = 1
        layer.borderColor = Appearance.white.withAlphaComponent(0.1).cgColor
    }
}

// MARK: Make constraints
private extension WorkoutNameLabelView {
    func makeConstrains() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.scale),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension WorkoutNameLabelView {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
