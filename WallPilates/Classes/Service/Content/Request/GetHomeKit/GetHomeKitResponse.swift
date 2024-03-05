//
//  GetHomeKitResponse.swift
//  Soccer
//
//  Created by Андрей Чернышев on 06.02.2023.
//

import Foundation

final class GetHomeKitResponse {
    static func map(from response: Any) -> HomeKit? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let score = data["score"] as? Int,
            let levelId = data["level_id"] as? Int,
            let dailyPicks = data["daily_picks"] as? [String: Any],
            let dailyDrillsArray = dailyPicks["drills"] as? [[String: Any]],
            let dailyWorkoutsArray = dailyPicks["workouts"] as? [[String: Any]],
            let tryDrillsArray = data["try_drills"] as? [[String: Any]]
        else {
            return nil
        }
        
        let planJSON = data["plan"] as? [String: [String: Any]]
        
        let dailyDrills = map(drillsArray: dailyDrillsArray)
        let dailyWorkouts = map(dailyWorkoutsArray: dailyWorkoutsArray)
        let plan = GetPlanResponse.map(planJSON: planJSON ?? [:])
        let tryDrills = map(drillsArray: tryDrillsArray)
        
        return HomeKit(
            score: score,
            levelId: levelId,
            dailyDrills: dailyDrills,
            dailyWorkouts: dailyWorkouts,
            plan: plan,
            tryDrills: tryDrills
        )
    }
}

// MARK: Private
private extension GetHomeKitResponse {
    static func map(drillsArray: [[String: Any]]) -> [Drill] {
        drillsArray.compactMap { drillJSON -> Drill? in
            guard
                let id = drillJSON["drill_id"] as? Int,
                let name = drillJSON["name"] as? String,
                let skillLevelId = drillJSON["level_id"] as? Int,
                let imagePath = drillJSON["image"] as? String,
                let imageUrl = URL(string: imagePath),
                let categoryId = drillJSON["drill_category_id"] as? Int,
                let paid = drillJSON["paid"] as? Bool,
                let explanation = drillJSON["explanation"] as? String,
                let instruction = drillJSON["description"] as? String
            else {
                return nil
            }
            
            return Drill(
                id: id,
                name: name,
                skillLevelId: skillLevelId,
                image: imageUrl,
                categoryId: categoryId,
                paid: paid,
                explanation: explanation,
                instruction: instruction
            )
        }
    }
    
    static func map(dailyWorkoutsArray: [[String: Any]]) -> [WorkoutTemplate] {
        dailyWorkoutsArray.compactMap { workoutJSON -> WorkoutTemplate? in
            guard
                let id = workoutJSON["template_workout_id"] as? Int,
                let name = workoutJSON["name"] as? String,
                let imagePath = workoutJSON["image"] as? String,
                let imageUrl = URL(string: imagePath),
                let levelId = workoutJSON["level_id"] as? Int,
                let focusZonesIds = workoutJSON["body_part_ids"] as? [Int],
                let exercisesBundleArray = workoutJSON["training_steps"] as? [[String: Any]]
            else {
                return nil
            }
            
            let exercises = exercisesBundleArray.reduce([]) { result, exercisesBundleJSON -> [WorkoutExercise] in
                guard
                    let workoutStepId = exercisesBundleJSON["training_step_id"] as? Int,
                    let exercisesArray = exercisesBundleJSON["exercises"] as? [[String: Any]]
                else {
                    return result
                }
                
                let exercises = exercisesArray.compactMap { exerciseJSON -> WorkoutExercise? in
                    guard
                        let id = exerciseJSON["exercise_id"] as? Int,
                        let name = exerciseJSON["name"] as? String,
                        let subTitle = exerciseJSON["subtitle"] as? String,
                        let imagePath = exerciseJSON["image"] as? String,
                        let imageUrl = URL(string: imagePath),
                        let instruction = exerciseJSON["instruction"] as? String
                    else {
                        return nil
                    }
                    
                    return WorkoutExercise(
                        id: id,
                        name: name,
                        subTitle: subTitle,
                        image: imageUrl,
                        instruction: instruction,
                        workoutStepId: workoutStepId
                    )
                }
                
                return result + exercises
            }
            
            return WorkoutTemplate(
                id: id,
                name: name,
                image: imageUrl,
                levelId: levelId,
                focusZonesIds: focusZonesIds,
                exercises: exercises
            )
        }
    }
}
