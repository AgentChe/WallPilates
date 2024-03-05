//
//  OPositionView.swift
//  Soccer
//
//  Created by Андрей Чернышев on 03.02.2023.
//

import UIKit

final class OPositionView: OSlideView {
    lazy var skipButton = makeSkipButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var footballFieldView = makeFootballFieldView()
    lazy var stButton = makePositionButton(position: "ST")
    lazy var lwButton = makePositionButton(position: "LW")
    lazy var camButton = makePositionButton(position: "CAM")
    lazy var rwButton = makePositionButton(position: "RW")
    lazy var cmlButton = makePositionButton(position: "CM")
    lazy var cmrButton = makePositionButton(position: "CM")
    lazy var dmButton = makePositionButton(position: "DM")
    lazy var lbButton = makePositionButton(position: "LB")
    lazy var rbButton = makePositionButton(position: "RB")
    lazy var cblButton = makePositionButton(position: "CB")
    lazy var cbrButton = makePositionButton(position: "CB")
    lazy var gkButton = makePositionButton(position: "GK")
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
private extension OPositionView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    @objc
    func tapped(sender: UIButton) {
        guard let positionButton = sender as? OPositionButton else {
            return
        }
        
        positionButton.marked.toggle()
        
        checkEnabled()
    }
    
    func checkEnabled() {
        let buttons = [
            stButton,
            lwButton,
            camButton,
            rwButton,
            cmlButton,
            cmrButton,
            dmButton,
            lbButton,
            rbButton,
            cblButton,
            cbrButton,
            gkButton
        ]
        let marked = buttons.contains(where: { $0.marked })
        continueButton.isHidden = !marked
    }
}

// MARK: Make constraints
private extension OPositionView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            skipButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 70.scale : 52.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 120.scale : 52.scale),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            footballFieldView.widthAnchor.constraint(equalToConstant: 292.scale),
            footballFieldView.heightAnchor.constraint(equalToConstant: 447.scale),
            footballFieldView.centerXAnchor.constraint(equalTo: centerXAnchor),
            footballFieldView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32.scale)
        ])
        
        NSLayoutConstraint.activate([
            stButton.widthAnchor.constraint(equalToConstant: 40.scale),
            stButton.heightAnchor.constraint(equalToConstant: 40.scale),
            stButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            stButton.topAnchor.constraint(equalTo: footballFieldView.topAnchor, constant: 87.scale)
        ])
        
        NSLayoutConstraint.activate([
            lwButton.widthAnchor.constraint(equalToConstant: 40.scale),
            lwButton.heightAnchor.constraint(equalToConstant: 40.scale),
            lwButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 88.scale),
            lwButton.topAnchor.constraint(equalTo: footballFieldView.topAnchor, constant: 139.scale)
        ])
        
        NSLayoutConstraint.activate([
            camButton.widthAnchor.constraint(equalToConstant: 40.scale),
            camButton.heightAnchor.constraint(equalToConstant: 40.scale),
            camButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            camButton.topAnchor.constraint(equalTo: footballFieldView.topAnchor, constant: 139.scale)
        ])
        
        NSLayoutConstraint.activate([
            rwButton.widthAnchor.constraint(equalToConstant: 40.scale),
            rwButton.heightAnchor.constraint(equalToConstant: 40.scale),
            rwButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 248.scale),
            rwButton.topAnchor.constraint(equalTo: footballFieldView.topAnchor, constant: 139.scale)
        ])
        
        NSLayoutConstraint.activate([
            cmlButton.widthAnchor.constraint(equalToConstant: 40.scale),
            cmlButton.heightAnchor.constraint(equalToConstant: 40.scale),
            cmlButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 113.scale),
            cmlButton.topAnchor.constraint(equalTo: footballFieldView.topAnchor, constant: 204.scale)
        ])
        
        NSLayoutConstraint.activate([
            cmrButton.widthAnchor.constraint(equalToConstant: 40.scale),
            cmrButton.heightAnchor.constraint(equalToConstant: 40.scale),
            cmrButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 223.scale),
            cmrButton.topAnchor.constraint(equalTo: footballFieldView.topAnchor, constant: 204.scale)
        ])
        
        NSLayoutConstraint.activate([
            dmButton.widthAnchor.constraint(equalToConstant: 40.scale),
            dmButton.heightAnchor.constraint(equalToConstant: 40.scale),
            dmButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            dmButton.topAnchor.constraint(equalTo: footballFieldView.topAnchor, constant: 248.scale)
        ])
        
        NSLayoutConstraint.activate([
            lbButton.widthAnchor.constraint(equalToConstant: 40.scale),
            lbButton.heightAnchor.constraint(equalToConstant: 40.scale),
            lbButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 76.scale),
            lbButton.topAnchor.constraint(equalTo: footballFieldView.topAnchor, constant: 272.scale)
        ])
        
        NSLayoutConstraint.activate([
            rbButton.widthAnchor.constraint(equalToConstant: 40.scale),
            rbButton.heightAnchor.constraint(equalToConstant: 40.scale),
            rbButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 260.scale),
            rbButton.topAnchor.constraint(equalTo: footballFieldView.topAnchor, constant: 272.scale)
        ])
        
        NSLayoutConstraint.activate([
            cblButton.widthAnchor.constraint(equalToConstant: 40.scale),
            cblButton.heightAnchor.constraint(equalToConstant: 40.scale),
            cblButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 113.scale),
            cblButton.topAnchor.constraint(equalTo: footballFieldView.topAnchor, constant: 312.scale)
        ])
        
        NSLayoutConstraint.activate([
            cbrButton.widthAnchor.constraint(equalToConstant: 40.scale),
            cbrButton.heightAnchor.constraint(equalToConstant: 40.scale),
            cbrButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 223.scale),
            cbrButton.topAnchor.constraint(equalTo: footballFieldView.topAnchor, constant: 312.scale)
        ])
        
        NSLayoutConstraint.activate([
            gkButton.widthAnchor.constraint(equalToConstant: 40.scale),
            gkButton.heightAnchor.constraint(equalToConstant: 40.scale),
            gkButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            gkButton.topAnchor.constraint(equalTo: footballFieldView.topAnchor, constant: 392.scale)
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
private extension OPositionView {
    func makeSkipButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(Appearance.white)
            .font(Fonts.Inter.regular(size: 14.scale))
        
        let view = TapAreaButton()
        view.backgroundColor = UIColor.clear
        view.setAttributedTitle("Onboarding.Skip".localized.attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.white)
            .font(Fonts.Inter.bold(size: 24.scale))
            .lineHeight(28.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.Position.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeFootballFieldView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Onboarding.Position")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePositionButton(position: String) -> OPositionButton {
        let view = OPositionButton(text: "Onboarding.Position." + position)
        view.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
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
