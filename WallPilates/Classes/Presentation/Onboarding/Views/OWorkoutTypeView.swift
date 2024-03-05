//
//  OWorkoutTypeView.swift
//  Soccer
//
//  Created by Андрей Чернышев on 03.02.2023.
//

import UIKit

final class OWorkoutTypeView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var cell1Button = makeCellButton(cellNumber: "1")
    lazy var cell2Button = makeCellButton(cellNumber: "2")
    lazy var cell3Button = makeCellButton(cellNumber: "3")
    lazy var cell4Button = makeCellButton(cellNumber: "4")
    lazy var cell5Button = makeCellButton(cellNumber: "5")
    lazy var continueButton = makeContinueButton()
    
    private lazy var buttons = [
        cell1Button,
        cell2Button,
        cell3Button,
        cell4Button,
        cell5Button
    ]
    
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
private extension OWorkoutTypeView {
    func initialize() {
        backgroundColor = Appearance.background
    }
    
    @objc
    func cellTapped(sender: UIButton) {
        guard let cellButton = sender as? OAgeButton else {
            return
        }
        
        buttons.forEach { $0.marked = false }
        cellButton.marked = true
        
        checkEnabled()
    }
    
    func checkEnabled() {
        let marked = buttons.contains(where: { $0.marked })
        continueButton.isHidden = !marked
    }
}

// MARK: Make constraints
private extension OWorkoutTypeView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 120.scale : 52.scale),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cell1Button.widthAnchor.constraint(equalToConstant: 343.scale),
            cell1Button.heightAnchor.constraint(equalToConstant: 80.scale),
            cell1Button.centerXAnchor.constraint(equalTo: centerXAnchor),
            cell1Button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell2Button.widthAnchor.constraint(equalToConstant: 343.scale),
            cell2Button.heightAnchor.constraint(equalToConstant: 80.scale),
            cell2Button.centerXAnchor.constraint(equalTo: centerXAnchor),
            cell2Button.topAnchor.constraint(equalTo: cell1Button.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 16.scale : 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell3Button.widthAnchor.constraint(equalToConstant: 343.scale),
            cell3Button.heightAnchor.constraint(equalToConstant: 80.scale),
            cell3Button.centerXAnchor.constraint(equalTo: centerXAnchor),
            cell3Button.topAnchor.constraint(equalTo: cell2Button.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 16.scale : 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell4Button.widthAnchor.constraint(equalToConstant: 343.scale),
            cell4Button.heightAnchor.constraint(equalToConstant: 80.scale),
            cell4Button.centerXAnchor.constraint(equalTo: centerXAnchor),
            cell4Button.topAnchor.constraint(equalTo: cell3Button.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 16.scale : 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell5Button.widthAnchor.constraint(equalToConstant: 343.scale),
            cell5Button.heightAnchor.constraint(equalToConstant: 80.scale),
            cell5Button.centerXAnchor.constraint(equalTo: centerXAnchor),
            cell5Button.topAnchor.constraint(equalTo: cell4Button.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 16.scale : 8.scale)
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
private extension OWorkoutTypeView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.white)
            .font(Fonts.Inter.bold(size: 24.scale))
            .lineHeight(28.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.WorkoutType.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCellButton(cellNumber: String) -> OAgeButton {
        let view = OAgeButton(age: ("Onboarding.WorkoutType.Cell" + cellNumber).localized)
        view.backgroundColor = Appearance.black
        view.layer.cornerRadius = 10.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(cellTapped(sender:)), for: .touchUpInside)
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
