//
//  Questions.swift
//  Rewisio
//
//  Created by Banu Karakaya on 28.02.2026.
//

import Foundation

struct QuizResponse: Codable {
    let status: Int
    let questions: [QuizQuestion]
}

struct QuizQuestion: Codable, Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let answer: String
    let source_url: String
}


