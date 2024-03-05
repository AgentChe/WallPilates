//
//  HomeDrillCoverCell.swift
//  Soccer
//
//  Created by Андрей Чернышев on 07.02.2023.
//

import UIKit
import Kingfisher

final class HomeDrillCoverCell: UITableViewCell {
    lazy var pictureView = makeImageView()
    lazy var drillTypeLabel = makeLabel(numberOfLines: 1)
    lazy var nameLabel = makeLabel(numberOfLines: 2)
    lazy var skillLevelLabel = makeLabel(numberOfLines: 1)
    lazy var arrowView = makeArrowView()
    
    private lazy var drillTypeAttrs = TextAttributes()
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
extension HomeDrillCoverCell {
    func setup(element: HomeDrillElement) {
        pictureView.kf.setImage(with: element.drill.image)
        
        drillTypeLabel.attributedText = element.drillCategory.name.uppercased().attributed(with: drillTypeAttrs)
        nameLabel.attributedText = element.drill.name.attributed(with: nameAttrs)
        skillLevelLabel.attributedText = element.skillLevel.name.attributed(with: skillLevelAttrs)
    }
}

// MARK: Private
private extension HomeDrillCoverCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension HomeDrillCoverCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pictureView.widthAnchor.constraint(equalToConstant: 90.scale),
            pictureView.heightAnchor.constraint(equalToConstant: 90.scale),
            pictureView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            drillTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 122.scale),
            drillTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -56.scale),
            drillTypeLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5.scale)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 122.scale),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -56.scale),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            skillLevelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 122.scale),
            skillLevelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -56.scale),
            skillLevelLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5.scale)
        ])
        
        NSLayoutConstraint.activate([
            arrowView.widthAnchor.constraint(equalToConstant: 32.scale),
            arrowView.heightAnchor.constraint(equalToConstant: 32.scale),
            arrowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            arrowView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension HomeDrillCoverCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8.scale
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.scale
        view.layer.borderColor = Appearance.white.withAlphaComponent(0.1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel(numberOfLines: Int) -> UILabel {
        let view = UILabel()
        view.numberOfLines = numberOfLines
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeArrowView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Home.Arrow")
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
