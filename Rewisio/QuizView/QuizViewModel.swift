//
//  QuizViewModel.swift
//  Rewisio
//
//  Created by Banu Karakaya on 9.01.2026.
//

import Foundation

struct Question {
    var question: String?
    var answerlabel: [String?]
}

protocol QuizViewModelProtocol {
    func viewDidLoad()
    func updateView()
}

protocol QuizViewModelDelegate: AnyObject {
    func prepareUI()
    func updateView()
}

final class QuizViewModel {
    weak var delegate: QuizViewModelDelegate?
    var questions: [Question] = [Question(question: "Banu Latif'i ne kadar seviyor?", answerlabel: ["çok", "çok çok", "baya çok", "anlatılamaz"]), Question(question: "Banu Latif'i ne kadar özlüyor?", answerlabel: ["çok", "çok çok", "baya çok", "anlatılamaz"]), Question(question: "Banu Latif'i ne kadar benimsiyor?", answerlabel: ["çok", "çok çok", "baya çok", "anlatılamaz"])]
    
    init(delegate: QuizViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension QuizViewModel: QuizViewModelProtocol {
    func updateView() {
        delegate?.updateView()
    }
    
    func viewDidLoad() {
        delegate?.prepareUI()
    }
}
