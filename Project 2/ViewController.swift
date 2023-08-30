//
//  ViewController.swift
//  Project 2
//
//  Created by Avinash Muralidharan on 28/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    
    var countries  = [String] ()
    var score = 0
    var correctAnswerIndex =  0
    var noOfQuestionsAnswered = 0
    var noOfCorrectlyAnsweredQuestions = 0
    var isPaused = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor
        
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func newGame(action:UIAlertAction! = nil){
        noOfQuestionsAnswered = 0
        score = 0
        noOfCorrectlyAnsweredQuestions = 0
        askQuestion()
    }
    
    func askQuestion(action:UIAlertAction! = nil){
        
        if noOfQuestionsAnswered == 10 {
            let newGameAlertController = UIAlertController(title: "Game Over", message: "You have got \(noOfCorrectlyAnsweredQuestions) out of 10 \n Your score is \(score)", preferredStyle: .alert)
            newGameAlertController.addAction(UIAlertAction(title:"New Game",style: .default,handler: newGame))
            present(newGameAlertController,animated: true)
        }
        
        
        
        countries.shuffle()
        
        correctAnswerIndex = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named:countries[0]), for: .normal)
        button2.setImage(UIImage(named:countries[1]), for: .normal)
        button3.setImage(UIImage(named:countries[2]), for: .normal)
        
        title = "Which flag is \(countries[correctAnswerIndex].uppercased())"
         
        toggleIcon()
    }
    
   
    @objc func checkScore() {
        
        toggleIcon()
        
        let scoreAlertController = UIAlertController(title: "Score", message: "Score : \(String(score))  \n Answers Correct : \(noOfCorrectlyAnsweredQuestions) \n Question \(noOfQuestionsAnswered) out of 10", preferredStyle: .alert)
        
        scoreAlertController.addAction(UIAlertAction(title: "Resume", style: .default,handler:toggleIcon))
        
        present(scoreAlertController,animated: true)
        
    }
    
    func toggleIcon(action: UIAlertAction! = nil ){
        
        isPaused = !isPaused
        
        var icon = isPaused ? UIBarButtonItem.SystemItem.play : UIBarButtonItem.SystemItem.pause
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem:icon, target: self,action: #selector(checkScore)), animated: true)
    }
    
    @IBAction func onTapped(_ sender: UIButton) {
     
        if noOfQuestionsAnswered == 10 {
            let newGameAlertController = UIAlertController(title:"Game Over", message: "You have got \(noOfCorrectlyAnsweredQuestions) correct out of 10 \n Your score is \(score)", preferredStyle: .alert)
            newGameAlertController.addAction(UIAlertAction(title: "New Game", style: .default,handler: newGame))
            present(newGameAlertController,animated: true)
        }
        
        noOfQuestionsAnswered += 1
        
        var title: String

        if sender.tag == correctAnswerIndex {
            title = "Correct !!!"
            score += 1
            noOfCorrectlyAnsweredQuestions += 1
        } else {
            title = "Wrong !!! \n That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }

        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)

    }
    
    
}
