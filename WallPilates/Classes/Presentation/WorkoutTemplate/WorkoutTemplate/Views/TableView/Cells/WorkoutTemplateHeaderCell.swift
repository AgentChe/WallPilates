//
//  WorkoutTemplateHeaderCell.swift
//  Soccer
//
//  Created by Андрей Чернышев on 14.03.2023.
//

import UIKit
import Kingfisher

final class WorkoutTemplateHeaderCell: UITableViewCell {
    lazy var pictureView = makeImageView()
    lazy var shadowView = makeShadowView()
    lazy var gradientView = makeGradientView()
    lazy var nameLabel = makeNameLabel()
    lazy var skillLevelLabel = makeTagLabel()
    
    private lazy var nameAttrs = TextAttributes()
        .textColor(Appearance.mono200)
        .font(Fonts.Inter.bold(size: 24.scale))
        .lineHeight(28.8.scale)
        .textAlignment(.center)
        .lineBreakMode(.byTruncatingTail)
    private lazy var tagAttrs = TextAttributes()
        .textColor(Appearance.mono200)
        .font(Fonts.Inter.semiBold(size: 12.scale))
        .lineHeight(14.4.scale)
        .textAlignment(.center)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension WorkoutTemplateHeaderCell {
    func setup(element: WorkoutTemplateHeaderElement) {
        pictureView.kf.setImage(with: element.image)
        
        nameLabel.attributedText = element.name.attributed(with: nameAttrs)
        skillLevelLabel.attributedText = element.skillLevel.attributed(with: tagAttrs)
    }
}

// MARK: Private
private extension WorkoutTemplateHeaderCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension WorkoutTemplateHeaderCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 182.scale)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -54.scale)
        ])
        
        NSLayoutConstraint.activate([
            skillLevelLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            skillLevelLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension WorkoutTemplateHeaderCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeShadowView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 9, green: 9, blue: 9, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeGradientView() -> GradientView {
        let view = GradientView()
        view.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        view.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.gradientLayer.colors = [
            UIColor(integralRed: 9, green: 9, blue: 9, alpha: 0).cgColor,
            UIColor(integralRed: 9, green: 9, blue: 9, alpha: 0.6).cgColor,
            UIColor(integralRed: 9, green: 9, blue: 9, alpha: 1).cgColor
        ]
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeNameLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeTagLabel() -> PaddingLabel {
        let view = PaddingLabel()
        view.backgroundColor = Appearance.mono200.withAlphaComponent(0.2)
        view.layer.cornerRadius = 11.scale
        view.layer.masksToBounds = true
        view.insets = UIEdgeInsets(top: 4.scale, left: 8.scale, bottom: 4.scale, right: 8.scale)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
