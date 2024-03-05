//
//  ProfileMainStatsCell.swift
//  Soccer
//
//  Created by Виталий Загороднов on 27.04.2023.
//

import UIKit

class ProfileMainStatsCell: UITableViewCell {
    
    private lazy var titlelabel = makeLabel()
    private lazy var drillStats = makeStatsView()
    private lazy var workoutStats = makeStatsView()
    private lazy var container = makeContainer()
    private lazy var pageContainer = makePageContainer()
    private lazy var page1 = makePage(color: Appearance.white)
    private lazy var page2 = makePage(color: Appearance.white.withAlphaComponent(0.4))
    
    private lazy var centerDrillStatConstraint = NSLayoutConstraint()
    private lazy var centerWorkoutStatConstraint = NSLayoutConstraint()
    private lazy var widthPage1Constraint = NSLayoutConstraint()
    private lazy var widthPage2Constraint = NSLayoutConstraint()
    
    private lazy var leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeHandler))
    private lazy var rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeHandler))
    
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
    func setup(drillValue: String, workoutValue: String) {
        drillStats.setup(value: drillValue, subtitle: "Profile.Completed.Drills".localized)
        workoutStats.setup(value: workoutValue, subtitle: "Profile.Completed.Workouts".localized)
    }
    
    @objc func leftSwipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            centerWorkoutStatConstraint.isActive = false
            centerDrillStatConstraint.isActive = true
            
            widthPage1Constraint.constant = 6.scale
            widthPage2Constraint.constant = 20.scale
            
            UIView.animate(withDuration: 0.2) {
                self.page1.backgroundColor = Appearance.white.withAlphaComponent(0.4)
                self.page2.backgroundColor = Appearance.white
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc func rightSwipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            centerDrillStatConstraint.isActive = false
            centerWorkoutStatConstraint.isActive = true
            
            widthPage1Constraint.constant = 20.scale
            widthPage2Constraint.constant = 6.scale
            
            
            UIView.animate(withDuration: 0.2) {
                self.page1.backgroundColor = Appearance.white.withAlphaComponent(0.4)
                self.page2.backgroundColor = Appearance.white
                self.layoutIfNeeded()
            }
        }
    }
}

// MARK: Private
private extension ProfileMainStatsCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        container.addGestureRecognizer(leftSwipe)
        container.addGestureRecognizer(rightSwipe)
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
            container.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 32.scale),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale)
        ])
        
        centerWorkoutStatConstraint = workoutStats.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        centerDrillStatConstraint = drillStats.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        NSLayoutConstraint.activate([
            centerWorkoutStatConstraint,
            workoutStats.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            drillStats.leadingAnchor.constraint(equalTo: workoutStats.trailingAnchor, constant: 10.scale),
            drillStats.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pageContainer.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            pageContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        
        widthPage1Constraint = page1.widthAnchor.constraint(equalToConstant: 20.scale)
        NSLayoutConstraint.activate([
            widthPage1Constraint,
            page1.leadingAnchor.constraint(equalTo: pageContainer.leadingAnchor),
            page1.topAnchor.constraint(equalTo: pageContainer.topAnchor),
            page1.bottomAnchor.constraint(equalTo: pageContainer.bottomAnchor),
            page1.heightAnchor.constraint(equalToConstant: 6.scale)
        ])
        
        widthPage2Constraint = page2.widthAnchor.constraint(equalToConstant: 6.scale)
        NSLayoutConstraint.activate([
            widthPage2Constraint,
            page2.heightAnchor.constraint(equalTo: page1.heightAnchor),
            page2.leadingAnchor.constraint(equalTo: page1.trailingAnchor, constant: 5.scale),
            page2.trailingAnchor.constraint(equalTo: pageContainer.trailingAnchor),
            page2.topAnchor.constraint(equalTo: pageContainer.topAnchor),
            page2.bottomAnchor.constraint(equalTo: pageContainer.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension ProfileMainStatsCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        let attrs = TextAttributes()
            .font(Fonts.Inter.semiBold(size: 20.scale))
            .lineHeight(24.scale)
            .textColor(Appearance.white)
            .textAlignment(.center)
        
        view.attributedText = "Profile.StatsTitle".localized.attributed(with: attrs)
        contentView.addSubview(view)
        return view
    }
    
    func makeStatsView() -> ProfileMainStatsView {
        let view = ProfileMainStatsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeContainer() -> ProfileMainScrollContainerView {
        let view = ProfileMainScrollContainerView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        contentView.addSubview(view)
        return view
    }
    
    func makePage(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3.scale
        view.backgroundColor = color
        pageContainer.addSubview(view)
        return view
    }
    
    func makePageContainer() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        container.addSubview(view)
        return view
    }
}
