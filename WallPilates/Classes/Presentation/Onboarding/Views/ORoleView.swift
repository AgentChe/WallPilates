//
//  ORoleView.swift
//  Soccer
//
//  Created by Андрей Чернышев on 01.02.2023.
//

import UIKit

final class ORoleView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var playerButton = makeRoleButton(role: .player)
    lazy var coachButton = makeRoleButton(role: .coach)
    lazy var amateurButton = makeRoleButton(role: .amateur)
    lazy var continueButton = makeContinueButton()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
        checkEnabled()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension ORoleView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    @objc
    func tapped(sender: UIButton) {
        guard let roleButton = sender as? ORoleButton else {
            return
        }
        
        [playerButton, coachButton, amateurButton].forEach { $0.marked = false }
        roleButton.marked = true
        
        checkEnabled()
    }
    
    func checkEnabled() {
        let marked = [playerButton, coachButton, amateurButton].contains(where: { $0.marked })
        continueButton.isHidden = !marked
    }
}

// MARK: Make constraints
private extension ORoleView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 120.scale : 52.scale),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            playerButton.widthAnchor.constraint(equalToConstant: 103.scale),
            playerButton.heightAnchor.constraint(equalToConstant: 121.scale),
            playerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23.scale),
            playerButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 160.scale : 160.scale)
        ])
        
        NSLayoutConstraint.activate([
            coachButton.widthAnchor.constraint(equalToConstant: 103.scale),
            coachButton.heightAnchor.constraint(equalToConstant: 121.scale),
            coachButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 136.scale),
            coachButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 160.scale : 160.scale)
        ])
        
        NSLayoutConstraint.activate([
            amateurButton.widthAnchor.constraint(equalToConstant: 103.scale),
            amateurButton.heightAnchor.constraint(equalToConstant: 121.scale),
            amateurButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 249.scale),
            amateurButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 160.scale : 160.scale)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            continueButton.heightAnchor.constraint(equalToConstant: 54.scale),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -62.scale : -32.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension ORoleView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.white)
            .font(Fonts.Inter.bold(size: 24.scale))
            .lineHeight(28.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Role.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeRoleButton(role: SoccerRole) -> ORoleButton {
        let view = ORoleButton(soccerRole: role)
        view.layer.cornerRadius = 10.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        addSubview(view)
        return view
    }
    
    func makeContinueButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.white)
            .font(Fonts.Inter.semiBold(size: 16.scale))
        
        let view = UIButton()
        view.backgroundColor = Appearance.primary
        view.layer.cornerRadius = 8.scale
        view.setAttributedTitle("Continue".localized.attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
