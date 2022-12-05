//
//  MiaABCBrain.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 12/1/22.
//

import Foundation

struct MiaABCBrain {
    var lesson = Lesson.animal
    var currentSet = [""]
    var currentLesson: [String: MiaABCItem] = [:]
    
    func makeLessonDictionary(set: [String], setSound: [String], lesson: [String: String]) -> [String: MiaABCItem] {
        var lessonDictionary: [String: MiaABCItem] = [:]
        var count = 0
        
        for item in set {
            lessonDictionary[item] = MiaABCItem(cellImage: item, cellImageSound: setSound[count], mainImageAndSound: lesson[item] ?? "a")
            count += 1
        }
        return lessonDictionary
    }
    
    enum Lesson {
        case animal, object, fruit, instrument, color, shape, number, toy
    }
    
    mutating func getLesson() {
        
        switch lesson {
            
        case .animal:
            currentSet = letterSetA
            currentLesson = makeLessonDictionary(set: letterSetA, setSound: cellSetSound, lesson: abcAnimalMainImages)
        case .object:
            currentSet = letterSetB
            currentLesson = makeLessonDictionary(set: letterSetB, setSound: cellSetSound, lesson: abcObjectMainImages)
        case .fruit:
            currentSet =  letterSetFruit
            currentLesson = makeLessonDictionary(set: letterSetFruit, setSound: cellSetSound, lesson: fruitsMainImages)
        case .instrument:
            print("Instruments")
        case .color:
            currentSet = colorsSet
            currentLesson = makeLessonDictionary(set: colorsSet, setSound: colorsSet, lesson: colorMainImages)
        case .shape:
            currentSet = shapesSet
            currentLesson = makeLessonDictionary(set: shapesSet, setSound: shapesSet, lesson: shapeMainImages)
        case .number:
            currentSet = numbersSet
            currentLesson = makeLessonDictionary(set: numbersSet, setSound: numbersSet, lesson: numbersMainVideos)
        case .toy:
            currentSet = toysSet
            currentLesson = makeLessonDictionary(set: toysSet, setSound: toysSet, lesson: toysMainImages)
        }
    }
    
    //MARK: - Cell Image Sound
    
    private let cellSetSound = [
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l" ,"m",
        "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    //MARK: - Cell Image Sets
    
    private let letterSetA = [
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l" ,"m",
        "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    private let letterSetB = [
        "a2", "b2", "c2", "d2", "e2", "f2", "g2", "h2", "i2", "j2", "k2", "l2" ,"m2",
        "n2", "o2", "p2", "q2", "r2", "s2", "t2", "u2", "v2", "w2", "x2", "y2", "z2"]

    private let letterSetFruit = [
        "aQuiz", "bQuiz", "cQuiz", "dQuiz", "eQuiz", "fQuiz", "gQuiz", "hQuiz", "iQuiz",
        "jQuiz", "kQuiz", "lQuiz" ,"mQuiz","nQuiz", "oQuiz", "pQuiz", "qQuiz", "rQuiz",
        "sQuiz", "tQuiz", "uQuiz", "vQuiz", "wQuiz", "xQuiz", "yQuiz", "zQuiz"]

    private let colorsSet = [
        "black", "blue", "brown", "cyan", "green",
        "magenta", "maroon", "orange", "pink", "purple",
        "red", "teal", "yellow", "grey", "white", "violet"]
    
    private let shapesSet: [String] = [
        "circle", "square", "triangle", "rectangle", "oval",
        "diamond", "star", "heart", "hexagon", "pentagon",
        "cross", "octogon", "crescent"]

    private let numbersSet: [String] = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
        "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
        "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]

    private let toysSet: [String] = [
        "balloon", "bath boat", "beach ball", "doll house", "jump rope", "legos",
        "letter blocks", "old phone", "puzzle cube", "puzzle pieces", "rocking horse",
        "rubber ducky", "sand toys", "skateboard", "spin wheel", "spinning top",
        "stuffed animal", "tea set", "toy phone", "toy robot", "toy rocket",
        "toy train", "toy truck", "water shooter", "windup car",
        "windup dinosaur"]
    
    //MARK: - Main View Image Sets
    
    private var abcAnimalMainImages: [String: String] = [
        "a": "alligator", "b": "bat", "c": "cat",
        "d": "dinosaur", "e": "elephant", "f": "frog",
        "g": "giraffe", "h": "horse", "i": "iguana",
        "j": "jellyfish", "k": "kangaroo", "l": "lion",
        "m": "monkey", "n": "narwal", "o": "octopus",
        "p": "penguin", "q": "queen angelfish", "r": "raccoon",
        "s": "snake", "t": "turtle", "u": "umbrella bird",
        "v": "volture", "w": "walrus", "x": "xray tetra",
        "y": "yak", "z": "zebra"]

    private var abcObjectMainImages: [String: String] = [
        "a2": "airplane", "b2": "ball", "c2": "car",
        "d2": "drum", "e2": "earphones", "f2": "flower",
        "g2": "ghost", "h2": "home", "i2": "icecream",
        "j2": "juice", "k2": "ketchup", "l2": "lightning",
        "m2": "moon", "n2": "nuts", "o2": "oven",
        "p2": "piano", "q2": "question", "r2": "rainbow",
        "s2": "smile", "t2": "trees", "u2": "unicorn",
        "v2": "violin", "w2": "wizard", "x2": "xylophone",
        "y2": "yeti", "z2": "zombie"]
    
    private let colorMainImages: [String: String] = [
        "black": "black butterfly", "blue": "blue bunny", "brown": "brown bear",
        "cyan": "cyan circle", "green": "green gecko", "grey": "ghost",
        "magenta": "magenta makeup", "maroon": "maroon milk", "orange": "orange octopus",
        "pink": "pink piggy", "purple": "purple pizza", "red": "red robot",
        "teal": "teal tank", "yellow": "yellow yak", "white": "white web",
        "violet": "violet flower"]

    private let shapeMainImages: [String: String] = [
        "circle": "wheel", "square": "box", "triangle": "pyramid",
        "rectangle": "mattress", "star": "tree star", "diamond": "street sign",
        "oval": "mirror", "heart": "valentines candy", "hexagon": "bolts",
        "pentagon": "bird house", "cross": "ambulance", "octogon": "stop sign",
        "crescent": "crescent moon"]

    private let fruitsMainImages: [String: String] = [
        "aQuiz": "avocado", "bQuiz": "bananas", "cQuiz": "coconut",
        "dQuiz": "dragon fruit", "eQuiz": "elderberry", "fQuiz": "fig",
        "gQuiz": "grapes", "hQuiz": "honeydew", "iQuiz": "iceberg lettuce",
        "jQuiz": "jalapeno", "kQuiz": "kiwi", "lQuiz": "lemon",
        "mQuiz": "mushroom", "nQuiz": "nectarine", "oQuiz": "oranges",
        "pQuiz": "peas", "qQuiz": "quince", "rQuiz": "radish",
        "sQuiz": "strawberry", "tQuiz": "turnip", "uQuiz": "ugli fruit",
        "vQuiz": "vanilla", "wQuiz": "watermellon", "xQuiz": "ximenia",
        "yQuiz": "yam", "zQuiz": "zucchini"]

    private let toysMainImages: [String: String] = [
        "balloon": "balloon", "bath boat": "bath boat", "beach ball": "beach ball",
        "doll house": "doll house", "jump rope": "jump rope", "legos": "legos",
        "letter blocks": "letter blocks", "old phone": "old phone",
        "puzzle cube": "puzzle cube", "puzzle pieces": "puzzle pieces", "rocking horse": "rocking horse",
        "rubber ducky": "rubber ducky", "sand toys": "sand toys", "skateboard": "skateboard",
        "spin wheel": "spin wheel", "spinning top": "spinning top",
        "stuffed animal": "stuffed animal", "tea set": "tea set", "toy phone": "toy phone",
        "toy robot": "toy robot", "toy rocket": "toy rocket",
        "toy train": "toy train", "toy truck": "toy truck",
        "water shooter": "water shooter", "windup car": "windup car",
        "windup dinosaur": "windup dinosaur"]
    
    private let numbersMainVideos: [String: String] = [
        "1": "1", "2": "2", "3": "3", "4": "4", "5": "5",
        "6": "6", "7": "7", "8": "8", "9": "9", "10": "10",
        "11": "1", "12": "12", "13": "13", "14": "14", "15": "15",
        "16": "16", "17": "17", "18": "18", "19": "19", "20": "20",
        "21": "21", "22": "22", "23": "23", "24": "24", "25": "25",
        "26": "26", "27": "27", "28": "28", "29": "29", "30": "30"]
}



