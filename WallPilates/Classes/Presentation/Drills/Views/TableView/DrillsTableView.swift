//
//  DrillTrainingsTableView.swift
//  Soccer
//
//  Created by Андрей Чернышев on 22.02.2023.
//

import UIKit

protocol DrillsTableDelegate: AnyObject {
    func drillsTableDidTap(element: DrillsTableElement)
}

final class DrillsTableView: UITableView {
    weak var mainDelegate: DrillsTableDelegate?
    
    lazy var elements = [DrillsTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension DrillsTableView {
    func setup(elements: [DrillsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension DrillsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: String(describing: DrillsTableCell.self)) as! DrillsTableCell
        cell.setup(element: elements[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension DrillsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220.scale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let element = elements[indexPath.row]
        mainDelegate?.drillsTableDidTap(element: element)
    }
}

// MARK: Private
private extension DrillsTableView {
    func initialize() {
        register(DrillsTableCell.self, forCellReuseIdentifier: String(describing: DrillsTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
