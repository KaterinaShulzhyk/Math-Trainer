//
//  TrainViewController.swift
//  MathsTrainer
//
//  Created by Shulzhyk Katsiaryna on 21/4/25.
//

import UIKit

protocol TrainViewControllerDelegate: AnyObject {
    func didUpdateScore(_ score: Int)
}

final class TrainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multiply:
                sign = "*"
            case .divide:
                sign = "/"
                
            }
        }
    }
    
    weak var delegate: TrainViewControllerDelegate?
    
    private var firstNumber = 0
    private var secondNumber  = 0
    private  var sign: String = ""
    private var count: Int = 0 {
        didSet {
            print("Count: \(count)")
            scoreLabel.text = "Score: \(count)"
            delegate? .didUpdateScore(count)
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureQuestion()
        configureButtons()
    }
    
    //MARK: - IBActions
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "",
              for: sender)
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "",
              for: sender)
    }
    
    
    // MARK: - Methods
    private func configureButtons() {
        let buttonsArray =  [leftButton, rightButton]
        
        buttonsArray.forEach { button in
            button?.backgroundColor = .systemYellow
        }
        // Add shadow
        buttonsArray.forEach { button in
            button?.layer.shadowColor = UIColor.darkGray.cgColor
            button?.layer.shadowOffset = CGSize(width: 0, height: 2)
            button?.layer.shadowOpacity = 0.4
            button?.layer.shadowRadius = 3
        }
        
        let isRightButton = Bool.random()
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        } while randomAnswer == answer
        
        rightButton.setTitle(isRightButton ? String(answer) : String(randomAnswer),
                             for: .normal)
        leftButton.setTitle(isRightButton ? String(randomAnswer): String(answer),
                            for: .normal)
    }
    
    private func configureQuestion() {
        switch type {
            
        case .add, .subtract, .multiply:
            firstNumber = Int.random(in: 1...99)
            secondNumber = Int.random(in: 1...99)
            
        case .divide:
            let divisor = Int.random(in: 2...20)
            let quotient = Int.random(in: 2...15)
            firstNumber = divisor * quotient
            secondNumber = divisor
        }
        
        questionLabel.text = "\(firstNumber) \(sign) \(secondNumber) ="
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .green :  .red
        
        if isRightAnswer {
            let isSecondAttempt = rightButton.backgroundColor == .red || leftButton.backgroundColor == .red
            
            count += isSecondAttempt ? 0 : 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in  self?.configureQuestion()
                self?.configureButtons()
            }
        }
    }
}


