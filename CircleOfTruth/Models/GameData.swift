//
//  QuestionsModel.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 5/31/22.
//

import Foundation

struct GameData: Codable {
    let category: String
    let questions: [String]
    let prompts: [String]
}

