//
//  QuizViewController.swift
//  Rewisio
//
//  Created by Banu Karakaya on 9.01.2026.
//

import UIKit

final class QuizViewController: UIViewController {

    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var optionView1: UIView!
    @IBOutlet weak var optionView2: UIView!
    @IBOutlet weak var optionView3: UIView!
    @IBOutlet weak var optionView4: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1Label: UILabel!
    @IBOutlet weak var answer2Label: UILabel!
    @IBOutlet weak var answer3Label: UILabel!
    @IBOutlet weak var answer4Label: UILabel!
    
    private lazy var viewModel: QuizViewModelProtocol = QuizViewModel(delegate: self)
    
    private var questionNumber = 0 {
            didSet {
                DispatchQueue.main.async { [weak self] in
                    self?.viewModel.updateView()
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        updateView()
    }
}

extension QuizViewController: QuizViewModelDelegate {
    func updateView() {
        var currentQuestion = viewModel.questionsArray[questionNumber].question
        var answerLabels = viewModel.questionsArray[questionNumber].answerlabel
        questionLabel.text = currentQuestion
        answer1Label.text = answerLabels[0]
        answer2Label.text = answerLabels[1]
        answer3Label.text = answerLabels[2]
        answer4Label.text = answerLabels[3]
    }
    
    func prepareUI() {
        cornerView.layer.cornerRadius = 16
        optionView1.layer.cornerRadius = 16
        optionView1.layer.shadowColor = UIColor.black.cgColor
        optionView1.layer.shadowOpacity = 0.15
        optionView1.layer.shadowOffset = CGSize(width: 0, height: 4)
        optionView1.layer.shadowRadius = 8
        
        optionView2.layer.cornerRadius = 16
        optionView2.layer.shadowColor = UIColor.black.cgColor
        optionView2.layer.shadowOpacity = 0.15
        optionView2.layer.shadowOffset = CGSize(width: 0, height: 4)
        optionView2.layer.shadowRadius = 8
        
        optionView3.layer.cornerRadius = 16
        optionView3.layer.shadowColor = UIColor.black.cgColor
        optionView3.layer.shadowOpacity = 0.15
        optionView3.layer.shadowOffset = CGSize(width: 0, height: 4)
        optionView3.layer.shadowRadius = 8
        
        optionView4.layer.cornerRadius = 16
        optionView4.layer.shadowColor = UIColor.black.cgColor
        optionView4.layer.shadowOpacity = 0.15
        optionView4.layer.shadowOffset = CGSize(width: 0, height: 4)
        optionView4.layer.shadowRadius = 8
        
        nextButton.layer.cornerRadius = 16
    }
}
