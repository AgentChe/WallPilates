//
//  TrainTitleCell.swift
//  Soccer
//
//  Created by Андрей Чернышев on 13.03.2023.
//

import UIKit

final class TrainTitleCell: UITableViewCell {
    lazy var nameLabel = makeLabel()
    lazy var seeAllLabel = makeSeeAllLabel()
    
    private let attrs = TextAttributes()
        .textColor(Appearance.mono200)
        .font(Fonts.Inter.semiBold(size: 20.scale))
        .lineHeight(24.scale)
        .textAlignment(.left)
    
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
extension TrainTitleCell {
    func setup(element: TrainTitleElement) {
        let args = args(from: element)
        
        nameLabel.attributedText = args.0.attributed(with: attrs)
        seeAllLabel.isHidden = args.1
    }
}

// MARK: Private
private extension TrainTitleCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func args(from element: TrainTitleElement) -> (String, Bool) {
        switch element {
        case .drillCategory(let drillCategory):
            return (drillCategory.name, false)
        case .workout(let workoutName):
            return (workoutName, true)
        }
    }
}

// MARK: Make constraints
private extension TrainTitleCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 43.scale)
        ])
        
        NSLayoutConstraint.activate([
            seeAllLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            seeAllLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TrainTitleCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeSeeAllLabel() -> PaddingLabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Inter.semiBold(size: 12.scale))
            .lineHeight(14.4.scale)
            .textAlignment(.center)
        
        let view = PaddingLabel()
        view.insets = UIEdgeInsets(top: 8.scale, left: 12.scale, bottom: 8.scale, right: 12.scale)
        view.backgroundColor = Appearance.mono100
        view.layer.cornerRadius = 6.scale
        view.layer.borderColor = Appearance.mono200.withAlphaComponent(0.1).cgColor
        view.layer.borderWidth = 1.scale
        view.attributedText = "Train.SeeAll".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
