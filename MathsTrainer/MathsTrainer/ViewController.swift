//
//  ViewController.swift
//  MathsTrainer
//
//  Created by Shulzhyk Katsiaryna on 21/4/25.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var subtractLabel: UILabel!
    @IBOutlet weak var multiplyLabel: UILabel!
    @IBOutlet weak var divideLabel: UILabel!
    
    // MARK: - Properties
    private var selectedType: MathTypes = .add
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
    }
    
    // MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwidAction(unwindSegue: UIStoryboardSegue) {}
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let TrainViewController = segue.destination as? TrainViewController {
            TrainViewController.delegate = self
            TrainViewController.type = selectedType
            
        }
    }
    
    private func configureButtons() {
        // Add shadow
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}

// MARK: - TrainViewControllerDelegate
extension ViewController: TrainViewControllerDelegate {
    func didUpdateScore(_ score: Int) {
        switch selectedType {
        case .add:
            addLabel.text = "Score: \(score)"
        case .subtract:
            subtractLabel.text = "Score: \(score)"
        case .multiply:
            multiplyLabel.text = "Score: \(score)"
        case .divide:
            divideLabel.text = "Score: \(score)"
        }
    }
}


