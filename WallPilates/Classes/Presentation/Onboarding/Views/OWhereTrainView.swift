//
//  OWhereTrainView.swift
//  Soccer
//
//  Created by Андрей Чернышев on 02.02.2023.
//

import UIKit

final class OWhereTrainView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var indoorButton = makeWhereTrainButton(iconName: "Onboarding.WhereTrain.Indoor",
                                                 name: "Onboarding.WhereTrain.Indoor".localized)
    lazy var outdoorButton = makeWhereTrainButton(iconName: "Onboarding.WhereTrain.Outdoor",
                                                  name: "Onboarding.WhereTrain.Outdoor".localized)
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
private extension OWhereTrainView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    @objc
    func tapped(sender: UIButton) {
        guard let whereTrainButton = sender as? OWhereTrainButton else {
            return
        }
        
        [indoorButton, outdoorButton].forEach { $0.marked = false }
        whereTrainButton.marked = true
        
        checkEnabled()
    }
    
    func checkEnabled() {
        let marked = [indoorButton, outdoorButton].contains(where: { $0.marked })
        continueButton.isHidden = !marked
    }
}

// MARK: Make constraints
private extension OWhereTrainView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 120.scale : 52.scale),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            indoorButton.widthAnchor.constraint(equalToConstant: 164.scale),
            indoorButton.heightAnchor.constraint(equalToConstant: 194.scale),
            indoorButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            indoorButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            outdoorButton.widthAnchor.constraint(equalToConstant: 164.scale),
            outdoorButton.heightAnchor.constraint(equalToConstant: 194.scale),
            outdoorButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 196.scale),
            outdoorButton.centerYAnchor.constraint(equalTo: centerYAnchor)
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
private extension OWhereTrainView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.white)
            .font(Fonts.Inter.bold(size: 24.scale))
            .lineHeight(28.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.WhereTrain.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeWhereTrainButton(iconName: String, name: String) -> OWhereTrainButton {
        let view = OWhereTrainButton(iconName: iconName, name: name)
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
