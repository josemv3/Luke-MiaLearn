//
//  MiaLearnsData.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 12/31/22.
//

import Foundation

struct MiaLearnsData {
    
    var lesson = Lesson.animal
    var lessonPromptSet = [String]()
    var lessonPromptSound = [String]()
    var lessonItems = [String]()
    var lessonItemSet = [String: String]() //links Prompt to Item
    var currentLesson = [String: MiaLearnsLesson]() //
    
    enum Lesson {
        case animal, object, fruit, number, color, shape, toy
    }
    
    mutating func makeMiaLearnsLesson(promptSet: [String], promptSound: [String], lessonItem: [String: String]) {
        var count = 0
        
        //let lessonItemSet2 = zip(promptSet, lessonItem).reduce(into: [:]) { $0[$1.0] = $1.1 }

        for item in promptSet {
            if promptSet.count != promptSound.count {
                print("Set and Sound are not the same length")
                break
            }
            currentLesson[item] = MiaLearnsLesson(promt: LessonPrompt(imageName: item, soundName: promptSound[count]), item: LessonItem(imageName: lessonItemSet[item] ?? "a", soundName: lessonItemSet[item] ?? "a"))
            count += 1
        }
    }
    
    //MARK: - ABC Lesson Letter Prompt (Image and sound for cells) / LessontItems (Image and sound for the word learned)
    
    enum LetterPrompt: String, CaseIterable {
        case a,b,c,d,e,f,g,h,i,j,k,l,m,
             n,o,p,q,r,s,t,u,v,w,x,y,z
    }
    
    enum AnimalItems: String, CaseIterable {
        case alligator, bat, cat, dinosaur, elephant, frog, giraffe, horse,
             iguana, jellyfish, kangaroo, lion, monkey, narwal, octopus,
             penguin, queen_angelfish, raccoon, snake, turtle, umbrella_bird,
             volture, walrus, xray_tetra, yak, zebra
    }
    
    enum ObjectItems: String, CaseIterable {
        case airplane, ball, car, drum, earphones, flower,
             ghost, home, icecream, juice, ketchup, lightning,
             moon, nuts, oven, piano, question, rainbow,
             smile, trees, unicorn, violin, wizard, xylophone,
             yeti, zombie
    }
    
    enum FruitItems: String, CaseIterable {
        case avocado, bell_pepper, coconut, dragon_fruit, elderberry, fig,
             grapes, honeydew, iceberg_lettuce, jalapeno, kiwi, lemon,
             mushroom, nectarine, oranges, peas, quince, radish,
             strawberry, turnip, ugli_fruit, vanilla, watermellon, ximenia,
             yam, zucchini
    }
    
    //MARK: - Non ABC Lessons - PromptSet (Image and sound inside cell) /  LessontItems (Image and sound for the word learned)
    
    //NumberSet uses map in switch statement to build promptSet.
    //lessonPromptSet = (0...30).map { String($0) }
    
    enum NumberItems: String, CaseIterable {
        case ladybug, frogs, birds, dogs, cats, racoons, butterflys, bears, whales,
             bees, penguins, ducks, turtles, pigs, sheep, bunnys, caterpillars, ants,
             spiders, fire_flys
    }
    
    enum ColorPrompt: String, CaseIterable {
        case black, blue, brown, cyan, green,
             magenta, maroon, orange, pink, purple,
             red, teal, yellow, grey, white, violet
    }
    
    enum ColorItems: String, CaseIterable {
        case black_butterfly, blue_bunny, brown_bear, cyan_circle, green_gecko,
             magenta_makeup, maroon_milk, orange_octopus, pink_piggy, purple_pizza,
             red_robot, teal_tank, yellow_yak, grey_ghost, white_web, violet_flower
    }
    
    enum ShapePrompt: String, CaseIterable {
        case circle, square, triangle, rectangle, star, diamond, oval,
             heart, hexagon, pentagon, cross, octogon, crescent
    }
    
    enum ShapeItems: String, CaseIterable {
        case wheel, box, pyramid, mattress, tree_star, street_sign, mirror,
             valentines_candy, bolts, bird_house, ambulance, stop_sign, crescent_moon
    }
    
    enum ToyPrompt: String, CaseIterable {
        case balloon, bath_boat, beach_ball, doll_house, jump_rope, legos,
             letter_blocks, old_phone, puzzle_cube, puzzle_pieces, rocking_horse,
             rubber_ducky, sand_toys, skateboard, spin_wheel, spinning_top,
             stuffed_animal, tea_set, toy_phone, toy_robot, toy_rocket,
             toy_train, toy_truck, water_shooter, windup_car,
             windup_dinosaur
    }
    
    enum ToyItems: String, CaseIterable {
        case balloon_svg, bath_boat_svg, beach_ball_svg, doll_house_svg, jump_rope_svg, legos_svg,
             letter_blocks_svg, old_phone_svg, puzzle_cube_svg, puzzle_pieces_svg, rocking_horse_svg,
             rubber_ducky_svg, sand_toys_svg, skateboard_svg, spin_wheel_svg, spinning_top_svg,
             stuffed_animal_svg, tea_set_svg, toy_phone_svg, toy_robot_svg, toy_rocket_svg,
             toy_train_svg, toy_truck_svg, water_shooter_svg, windup_car_svg,
             windup_dinosaur_svg
    }
    
    //add to original number for other letter sets
    mutating func getLesson() {
       
        switch lesson {
            
        case .animal:
            //Make Prompt Array for cell letter image and sound
            //lessonPromptSet = LetterPrompt.allCases.map { $0.rawValue } REPLACED with extension (allRAwValues)
            lessonPromptSet = LetterPrompt.allRawValues
            //Make sound name array
            lessonPromptSound = lessonPromptSet
            
            //Make Prompt and Item Dictionary
            lessonItems = AnimalItems.allRawValues
            lessonItemSet = zip(LetterPrompt.allRawValues, AnimalItems.allRawValues).reduce(into: [:]) { $0[$1.0] = $1.1 }
            
            //Complete lesson with custom item
            makeMiaLearnsLesson(promptSet: lessonPromptSet, promptSound: lessonPromptSet, lessonItem: lessonItemSet)
            
        case .object:
            lessonPromptSet = LetterPrompt.allCases.map { $0.rawValue + "2" }
            lessonPromptSound = LetterPrompt.allRawValues
            lessonItems = ObjectItems.allRawValues
            lessonItemSet = zip(lessonPromptSet, ObjectItems.allRawValues).reduce(into: [:]) { $0[$1.0] = $1.1 }
            makeMiaLearnsLesson(promptSet: lessonPromptSet, promptSound: lessonPromptSound, lessonItem: lessonItemSet)
            
        case .fruit:
            lessonPromptSet = LetterPrompt.allCases.map { $0.rawValue + "Quiz" }
            lessonPromptSound = LetterPrompt.allRawValues
            
            lessonItems = FruitItems.allRawValues
            lessonItemSet = zip(lessonPromptSet, FruitItems.allRawValues).reduce(into: [:]) { $0[$1.0] = $1.1 }
            makeMiaLearnsLesson(promptSet: lessonPromptSet, promptSound: lessonPromptSound, lessonItem: lessonItemSet)
            
        case .number:
            lessonPromptSet = (1...20).map { String($0) }
            lessonPromptSound = lessonPromptSet
            
            lessonItems = NumberItems.allRawValues
            lessonItemSet = zip(lessonPromptSet, NumberItems.allRawValues).reduce(into: [:]) { $0[$1.0] = $1.1 }
            makeMiaLearnsLesson(promptSet: lessonPromptSet, promptSound: lessonPromptSet, lessonItem: lessonItemSet)
            
        case .color:
            lessonPromptSet = ColorPrompt.allRawValues
            lessonPromptSound = lessonPromptSet
            
            lessonItems = ColorItems.allRawValues
            lessonItemSet = zip(lessonPromptSet, ColorItems.allRawValues).reduce(into: [:]) { $0[$1.0] = $1.1 }
            makeMiaLearnsLesson(promptSet: lessonPromptSet, promptSound: lessonPromptSound, lessonItem: lessonItemSet)
            
        case .shape:
            lessonPromptSet = ShapePrompt.allRawValues
            lessonPromptSound = lessonPromptSet
            
            lessonItems = ShapeItems.allRawValues
            lessonItemSet = zip(lessonPromptSet, ShapeItems.allRawValues).reduce(into: [:]) { $0[$1.0] = $1.1 }
            makeMiaLearnsLesson(promptSet: lessonPromptSet, promptSound: lessonPromptSound, lessonItem: lessonItemSet)
            
        case .toy:
            lessonPromptSet = ToyPrompt.allRawValues
            lessonPromptSound = lessonPromptSet
            
            lessonItems = ToyItems.allRawValues
            lessonItemSet = zip(lessonPromptSet, ToyItems.allRawValues).reduce(into: [:]) { $0[$1.0] = $1.1 }
            makeMiaLearnsLesson(promptSet: lessonPromptSet, promptSound: lessonPromptSound, lessonItem: lessonItemSet)
        }
    }
}

extension CaseIterable where Self: RawRepresentable {
    static var allRawValues: [RawValue] {
        //if .object return rawValue + "2"
        //if .fruit return rawValue + "Quiz"
        //else
        return allCases.map({ $0.rawValue })
    }
}


//In ShapePRomt enum
//      Tying each enum to another so order doesnt matter:
//        var item: String {
//            switch self {
//            case .circle:
//                return ShapeItems.wheel.rawValue
