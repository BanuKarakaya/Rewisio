//
//  Questions.swift
//  Rewisio
//
//  Created by Banu Karakaya on 28.02.2026.
//

import Foundation

// MARK: - Question Model
struct Question: Codable {
    let question: String
    let options: [String]
    let answer: String
    let source_url: String
}

// MARK: - Response from Supabase Edge Function
struct GenerateQuestionsResponse: Codable {
    let status: Int?
    let questions: [Question]?
    let error: String?
    let debug: String?
}


