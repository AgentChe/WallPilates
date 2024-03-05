//
//  OGoalsView.swift
//  Soccer
//
//  Created by Андрей Чернышев on 02.02.2023.
//

import UIKit

final class OGoalsView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var goal1View = makeGoalButton(iconName: "Onboarding.Goal.1".localized,
                                        text: "Onboarding.Goals.1".localized)
    lazy var goal2View = makeGoalButton(iconName: "Onboarding.Goal.2".localized,
                                        text: "Onboarding.Goals.2".localized)
    lazy var goal3View = makeGoalButton(iconName: "Onboarding.Goal.3".localized,
                                        text: "Onboarding.Goals.3".localized)
    lazy var goal4View = makeGoalButton(iconName: "Onboarding.Goal.4".localized,
                                        text: "Onboarding.Goals.4".localized)
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
private extension OGoalsView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    @objc
    func tapped(sender: UIButton) {
        guard let goalButton = sender as? OGoalButton else {
            return
        }
        
        goalButton.marked.toggle()
        
        checkEnabled()
    }
    
    func checkEnabled() {
        let buttons = [
            goal1View,
            goal2View,
            goal3View,
            goal4View
        ]
        let marked = buttons.contains(where: { $0.marked })
        continueButton.isHidden = !marked
    }
}

// MARK: Make constraints
private extension OGoalsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 120.scale : 52.scale),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            goal1View.widthAnchor.constraint(equalToConstant: 343.scale),
            goal1View.heightAnchor.constraint(equalToConstant: 80.scale),
            goal1View.centerXAnchor.constraint(equalTo: centerXAnchor),
            goal1View.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.scale)
        ])
        
        NSLayoutConstraint.activate([
            goal2View.widthAnchor.constraint(equalToConstant: 343.scale),
            goal2View.heightAnchor.constraint(equalToConstant: 80.scale),
            goal2View.centerXAnchor.constraint(equalTo: centerXAnchor),
            goal2View.topAnchor.constraint(equalTo: goal1View.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            goal3View.widthAnchor.constraint(equalToConstant: 343.scale),
            goal3View.heightAnchor.constraint(equalToConstant: 80.scale),
            goal3View.centerXAnchor.constraint(equalTo: centerXAnchor),
            goal3View.topAnchor.constraint(equalTo: goal2View.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            goal4View.widthAnchor.constraint(equalToConstant: 343.scale),
            goal4View.heightAnchor.constraint(equalToConstant: 80.scale),
            goal4View.centerXAnchor.constraint(equalTo: centerXAnchor),
            goal4View.topAnchor.constraint(equalTo: goal3View.bottomAnchor, constant: 16.scale)
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
private extension OGoalsView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.white)
            .font(Fonts.Inter.bold(size: 24.scale))
            .lineHeight(28.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Goals.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeGoalButton(iconName: String, text: String) -> OGoalButton {
        let view = OGoalButton(iconName: iconName, text: text)
        view.backgroundColor = Appearance.black
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
