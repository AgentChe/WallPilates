//
//  TrainFilterView.swift
//  Soccer
//
//  Created by Андрей Чернышев on 13.03.2023.
//

import UIKit

final class TrainFilterView: UIView {
    enum Filter {
        case drills, workouts
    }
    
    var filter = Filter.drills {
        didSet {
            update()
        }
    }
    
    lazy var separator = makeSeparator()
    lazy var drillsButton = makeButton(text: "Train.Filter.Drills".localized)
    lazy var workoutsButton = makeButton(text: "Train.Filter.Workouts".localized)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension TrainFilterView {
    func update() {
        drillsButton.marked = filter == .drills
        workoutsButton.marked = filter == .workouts
    }
}

// MARK: Make constraints
private extension TrainFilterView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.scale),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            drillsButton.widthAnchor.constraint(equalToConstant: 50.scale),
            drillsButton.heightAnchor.constraint(equalToConstant: 34.scale),
            drillsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            drillsButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            workoutsButton.widthAnchor.constraint(equalToConstant: 71.scale),
            workoutsButton.heightAnchor.constraint(equalToConstant: 34.scale),
            workoutsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 86.scale),
            workoutsButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TrainFilterView {
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = Appearance.white.withAlphaComponent(0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton(text: String) -> TrainFilterButton {
        let view = TrainFilterButton(text: text)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
