//
//  ProfileCalendarDayCell.swift
//  Soccer
//
//  Created by Виталий Загороднов on 26.04.2023.
//

import UIKit
import JTAppleCalendar

class ProfileCalendarDayCell: JTACDayCell {
    
    private lazy var weekDayLabel = makeLabel()
    private lazy var dayLabel = makeLabel()
    private lazy var statusView = makeStatusView()
    private lazy var daySelectView = makeDaySelectView()
    
    private lazy var statusViewWidth = NSLayoutConstraint()
    
    private lazy var dayAttrs = TextAttributes()
        .textColor(Appearance.white)
        .font(Fonts.Inter.regular(size: 16.scale))
        .lineHeight(25.6.scale)
        .textAlignment(.center)
    
    private lazy var weekDayAttrs = TextAttributes()
        .font(Fonts.Inter.regular(size: 12.scale))
        .lineHeight(16.scale)
        .textAlignment(.center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension ProfileCalendarDayCell {
    func setup(isSelected: Bool) {
        daySelectView.layer.borderWidth = isSelected ? 2.scale : 0
        daySelectView.layer.borderColor = isSelected ? Appearance.secondary.cgColor : UIColor.clear.cgColor
    }
    
    func setup(isCurrentDay: Bool) {
        daySelectView.backgroundColor = isCurrentDay
            ? Appearance.white.withAlphaComponent(0.2)
            : UIColor.clear
        weekDayLabel.textColor = isCurrentDay
            ? Appearance.secondary
            : Appearance.white.withAlphaComponent(0.7)
    }
    
    func setup(status: PlanStatus?, text: String, weekDay: DaysOfWeek) {
        dayLabel.attributedText = text.attributed(with: dayAttrs)
        weekDayLabel.attributedText = weekDay.dayName.attributed(with: weekDayAttrs)
        guard let status = status else {
            statusView.isHidden = true
            return
        }
        
        statusView.isHidden = false
        
        statusViewWidth.isActive = false
        switch status {
        case .skipped:
            statusView.backgroundColor = Appearance.primary
            statusViewWidth.constant = 15.scale
        case .planned:
            statusView.backgroundColor = Appearance.fourth
            statusViewWidth.constant = 6.scale
        case .completed:
            statusView.backgroundColor = Appearance.third
            statusViewWidth.constant = 15.scale
        }
        statusViewWidth.isActive = true
        layoutIfNeeded()
    }
}

// MARK: Make constraints
private extension ProfileCalendarDayCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            weekDayLabel.topAnchor.constraint(equalTo: topAnchor),
            weekDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            daySelectView.widthAnchor.constraint(equalToConstant: 40.scale),
            daySelectView.heightAnchor.constraint(equalToConstant: 40.scale),
            daySelectView.centerXAnchor.constraint(equalTo: dayLabel.centerXAnchor),
            daySelectView.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayLabel.topAnchor.constraint(equalTo: weekDayLabel.bottomAnchor, constant: 17.scale)
        ])
        
        statusViewWidth = statusView.widthAnchor.constraint(equalToConstant: 6.scale)
        NSLayoutConstraint.activate([
            statusViewWidth,
            statusView.heightAnchor.constraint(equalToConstant: 6.scale),
            statusView.centerXAnchor.constraint(equalTo: centerXAnchor),
            statusView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4.scale),
            statusView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 17.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension ProfileCalendarDayCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeDaySelectView() -> CircleView {
        let view = CircleView()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeStatusView() -> UIView {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 3.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

private extension JTAppleCalendar.DaysOfWeek {
    var dayName: String {
        switch self {
        case .sunday:
            return "Profile.DaysOfWeek.Su".localized
        case .monday:
            return "Profile.DaysOfWeek.Mo".localized
        case .tuesday:
            return "Profile.DaysOfWeek.Tu".localized
        case .wednesday:
            return "Profile.DaysOfWeek.We".localized
        case .thursday:
            return "Profile.DaysOfWeek.Th".localized
        case .friday:
            return "Profile.DaysOfWeek.Fr".localized
        case .saturday:
            return "Profile.DaysOfWeek.Sa".localized
        }
    }
}
