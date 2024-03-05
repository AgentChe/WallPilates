//
//  DrillTrainingResultViewModel.swift
//  Soccer
//
//  Created by Андрей Чернышев on 14.03.2023.
//

import RxSwift
import RxCocoa

final class DrillTrainingResultViewModel {
    lazy var skillLevel = makeSkillLevel()
    lazy var drillCategory = makeDrillCategory()
    
    private let drillTraining: Driver<DrillTraining>
    
    private lazy var drillManager = DrillManager()
    private lazy var contentManager = ContentManager()
    
    init(drillTraining: DrillTraining) {
        self.drillTraining = BehaviorRelay(value: drillTraining).asDriver()
    }
}

// MARK: Public
extension DrillTrainingResultViewModel {
    func makeSkillLevel() -> Driver<SkillLevel> {
        drillTraining
            .flatMapLatest { [weak self] drillTraining -> Driver<SkillLevel> in
                guard let self = self else {
                    return .never()
                }
                
                return self.contentManager
                    .obtainLevels(forceUpdate: false)
                    .compactMap { skillLevels -> SkillLevel? in
                        skillLevels.first(where: { $0.id == drillTraining.drill.skillLevelId })
                    }
                    .asDriver(onErrorDriveWith: .never())
            }
    }
    
    func makeDrillCategory() -> Driver<DrillCategory> {
        drillTraining
            .flatMapLatest { [weak self] drillTraining -> Driver<DrillCategory> in
                guard let self = self else {
                    return .never()
                }
                
                return self.drillManager
                    .obtainDrillCategories(forceUpdate: false)
                    .compactMap { drillCategories -> DrillCategory? in
                        drillCategories.first(where: { $0.id == drillTraining.drill.categoryId })
                    }
                    .asDriver(onErrorDriveWith: .never())
            }
    }
}
