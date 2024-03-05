//
//  TrainTableElement.swift
//  Soccer
//
//  Created by Андрей Чернышев on 13.03.2023.
//

import Foundation

struct TrainTableSection {
    let elements: [TrainTableElement]
}

enum TrainTableElement {
    case title(TrainTitleElement)
    case trainings([TrainTrainigElement])
}

enum TrainTitleElement {
    case drillCategory(DrillCategory)
    case workout(String)
}

struct TrainTrainigElement {
    enum Training {
        case drill(Drill)
        case workoutCover(WorkoutCover)
        case focusZone(FocusZone)
        case workoutStep(WorkoutStep)
    }
    
    let training: Training
    let image: URL
    let name: String
    let tag1: String
    let tag2: String?
}
