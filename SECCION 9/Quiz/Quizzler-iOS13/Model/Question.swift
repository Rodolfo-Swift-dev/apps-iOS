//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by rodoolfo gonzalez on 12-04-23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct Question{
    let text : String
    let answer : [String]
    let correctAnswer : String
    init( q : String, a : [String], correctAnswer : String ) {
        text = q
        answer = a
        self.correctAnswer = correctAnswer
    }
}
