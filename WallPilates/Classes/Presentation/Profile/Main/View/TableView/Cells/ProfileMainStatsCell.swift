//
//  ProfileMainStatsCell.swift
//  Soccer
//
//  Created by Виталий Загороднов on 27.04.2023.
//

import UIKit

final class ProfileMainStatsCell: UITableViewCell {
    lazy var titlelabel = makeTitleLabel()
    lazy var timeLabel = makeLabel()
    lazy var timeDescriptionLabel = makeTimeDescriptionLabel()
    
    private lazy var formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour]
        formatter.unitsStyle = .positional
        return formatter
    }()
    
    private lazy var timeAttrs = TextAttributes()
        .textColor(Appearance.secondary)
        .font(Fonts.Inter.bold(size: 50.scale))
        .lineHeight(60.scale)
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
extension ProfileMainStatsCell {
    func setup(trainingCompletedSeconds: Int) {
        // TODO: формат отображения и текст
        let time = formatter.string(from: TimeInterval(trainingCompletedSeconds))
        timeLabel.attributedText = time?.attributed(with: timeAttrs)
    }
}

// MARK: Private
private extension ProfileMainStatsCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension ProfileMainStatsCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titlelabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titlelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            titlelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            timeLabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 32.scale)
        ])
        
        NSLayoutConstraint.activate([
            timeDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            timeDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            timeDescriptionLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16.scale),
            timeDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension ProfileMainStatsCell {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .font(Fonts.Inter.semiBold(size: 20.scale))
            .lineHeight(24.scale)
            .textColor(Appearance.white)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Profile.StatsTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeTimeDescriptionLabel() -> UILabel {
        let attrs = TextAttributes()
            .font(Fonts.Inter.regular(size: 16.scale))
            .lineHeight(25.6.scale)
            .textColor(Appearance.black)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Profile.StatsDescription".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
