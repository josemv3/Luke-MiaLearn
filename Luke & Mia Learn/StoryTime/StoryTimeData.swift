//
//  StoryTimeData.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 2/21/23.
//

import UIKit
import AVFoundation

struct StoryTimeData {
    let imageNames = dragonImageNames.allCases.map { $0.rawValue }
    let videoNames = dragonVideoNames.allCases.map { $0.rawValue }
    var mediaCount = 0
    
    enum dragonImageNames: String, CaseIterable {
        case dragon1, dragon2, dragon3, dragon4,
             dragon5, dragon6, dragon7, dragon8,
             dragon9, dragon10, dragon11
    }
    
    enum dragonVideoNames: String, CaseIterable {
        case miaDragon1, miaDragon2, miaDragon3, miaDragon4,
             miaDragon5, miaDragon6, miaDragon7, miaDragon8,
             miaDragon9, miaDragon10, miaDragon11
    }
}




    //Make text button for pop up display sentence

//let dragonDialog = [
//"I want a Dragon and I can fly in the clouds and have fun with the birds",
//"Then the Dragon can make a loud noise at my brother. My brother doesn't like it. RAAaaaaAHHR!",
//"I want my Dragon can do fire. He can cook my smarshmallows",
//"I was laying at night and wishing and wishing for a Dragon. I'm wishing in my dream when I'm sleeping in the night time.",
//"Becasue I lost my stuffed Dragon at the Disney park",
//"I want my Dragon to block the sun on my way to school. It gets in my eyes.",
//"I can take my Dragon to school with me and we can have lots of fun.",
//"When I bring my Dragon to school the teachers gonna be really angry",
//"There is going to be baloons all around class. They have water and lots of flowers in them. The baloons can turn someone, when they are a stuffed animal, into a monkey or crab!",
//"So the teacher throws the wet balloon at the Dragon and he turns into a monkey and falls.",
//"My Dragon is a Monkey. The End."
//]
