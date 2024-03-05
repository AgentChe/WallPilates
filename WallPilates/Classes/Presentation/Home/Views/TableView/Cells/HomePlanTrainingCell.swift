//
//  HomePlanTrainingCell.swift
//  Soccer
//
//  Created by Андрей Чернышев on 11.03.2023.
//

import UIKit
import Kingfisher

final class HomePlanTrainingCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var pictureView = makeImageView()
    lazy var typeLabel = makeLabel(numberOfLines: 1)
    lazy var nameLabel = makeLabel(numberOfLines: 2)
    lazy var skillLevelLabel = makeLabel(numberOfLines: 1)
    
    private lazy var typeAttrs = TextAttributes()
        .textColor(Appearance.primary)
        .font(Fonts.Inter.regular(size: 12.scale))
        .lineHeight(15.6.scale)
        .letterSpacing(0.41.scale)
        .textAlignment(.left)
    private lazy var nameAttrs = TextAttributes()
        .textColor(Appearance.white)
        .font(Fonts.Inter.semiBold(size: 16.scale))
        .lineHeight(20.8.scale)
        .textAlignment(.left)
    private lazy var skillLevelAttrs = TextAttributes()
        .textColor(Appearance.white.withAlphaComponent(0.5))
        .font(Fonts.Inter.regular(size: 14.scale))
        .lineHeight(18.2.scale)
        .textAlignment(.left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pictureView.kf.cancelDownloadTask()
        pictureView.image = nil
    }
}

// MARK: Public
extension HomePlanTrainingCell {
    func setup(element: HomePlanTrainingElement) {
        switch element.training {
        case .drill(let drill):
            pictureView.kf.setImage(with: drill.image)
            typeLabel.attributedText = "Home.Drill".localized.uppercased().attributed(with: typeAttrs)
            nameLabel.attributedText = drill.name.attributed(with: nameAttrs)
        case .workout(let workout):
            pictureView.kf.setImage(with: workout.image)
            typeLabel.attributedText = "Home.Training".localized.uppercased().attributed(with: typeAttrs)
            nameLabel.attributedText = workout.name.attributed(with: nameAttrs)
        }
        
        skillLevelLabel.attributedText = element.skillLevel.name.attributed(with: skillLevelAttrs)
    }
}

// MARK: Private
private extension HomePlanTrainingCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension HomePlanTrainingCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pictureView.widthAnchor.constraint(equalToConstant: 90.scale),
            pictureView.heightAnchor.constraint(equalToConstant: 90.scale),
            pictureView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            pictureView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            typeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 122.scale),
            typeLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            typeLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5.scale)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 122.scale),
            nameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            nameLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            skillLevelLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 122.scale),
            skillLevelLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            skillLevelLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension HomePlanTrainingCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = Appearance.black
        view.layer.cornerRadius = 10.scale
        view.layer.borderWidth = 1.scale
        view.layer.borderColor = Appearance.white.withAlphaComponent(0.1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8.scale
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.scale
        view.layer.borderColor = Appearance.white.withAlphaComponent(0.1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeLabel(numberOfLines: Int) -> UILabel {
        let view = UILabel()
        view.numberOfLines = numberOfLines
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
