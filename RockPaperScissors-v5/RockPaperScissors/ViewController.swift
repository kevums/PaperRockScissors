//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Kevin Landry on 9/27/20.
//

import UIKit

class ViewController: UIViewController{
 // step 1 - link UI buttons and labels in both outlet and action form (if applicable); only buttons for actions here as the labels are only utilized as info outputs (see line 110 below)
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var gameResultLabel: UILabel!
    @IBOutlet weak var robotChatBubble: UIImageView!
    @IBOutlet weak var robotChat: UILabel!
    @IBOutlet weak var robotImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideLabelAndChat()
        hideResetButton()
    }
//step 2 - create an enum with cases related to the applicable selections available in this game, ala "paper", "rock", "scissors"
//ensure to keep using enum names non plural and in uppercamel
//for plain enums without associated values, conform your enum to CaseIterable protocol
    enum Choice: CaseIterable {
        case rock, paper, scissors
    }
//step 3 - assign variables names/values of the enum parameter Choice; then running the random element function from that selection; player choice variable is set to a default enum; the three chat strings will be created post-step 4 as a means to consolidate the main gameplay function in both appearance and utility
//also, using variables for ease of labeling; nested ifs was another way i guess
    let paperChat = "b33p b00p i chose paper"
    let rockChat = "b33p b00p i chose rock"
    let scissorsChat = "b33p b00p i chose scissors"
    var winCount = 0
//step 6 - dat feature creep (also line 68...shhhhhhh)
    let paperSound = SimpleSound(named: "paper")
    let rockSound = SimpleSound(named: "rock")
    let scissorsSound = SimpleSound(named: "scissors")
    let comboBreaker = SimpleSound(named: "combobreaker")
    let mortalKombat = SimpleSound(named: "mortalkombat")

//step 4 - planning of the main gameplay function yields early areas for consolidation, namely in the labels and chat bubble as well as the game result label; functions serve to easily allow replication of what would be repetition otherwise
    func hideLabelAndChat(){
        gameResultLabel.isHidden = true
        robotChatBubble.isHidden = true
    }
    
    func showLabelandChat(){
        gameResultLabel.isHidden = false
        robotChatBubble.isHidden = false
    }
    
    func hideResetButton(){
        resetButton.isHidden = true
    }
    
    func showResetButton(){
        resetButton.isHidden = false
    }
    
    func gameResultWin(){
        gameResultLabel.textColor = .systemGreen
        gameResultLabel.text = "WINNER!"
        winCount += 1
    }
    
    func gameResultLoss(){
        gameResultLabel.textColor = .systemRed
        gameResultLabel.text = "LOSER!"
        winCount = 0
    }
    
    func aNewChallenger(){
        if winCount == 3{
            robotImage.image = UIImage(named: "lordlarry")
            robotImage.layer.cornerRadius = robotImage.frame.height/1.5
            mortalKombat.play()
        }
    }
//step 5 - create main and secondary gameplay functions that will allow the compLabel text within the bubble to update per the random case chosen(runs within the button actions below); main func, known as result, sets the robotChat text to blank (otherwise shows default in SwiftUI per label), calls the compChoice variable to be randomized, then moves into if statements to compare win/loss scenarios that return the applicable consolidated functions
    func compLabel(_ compChoice: Choice){
        if compChoice == Choice.paper{
            robotChat.text = paperChat
        }
        else if compChoice == Choice.rock{
            robotChat.text = rockChat
        }
        else if compChoice == Choice.scissors{
            robotChat.text = scissorsChat
        }
    }
// - a randomizer protocol for the computer choice is utilized here with the property allCases referring to all dot notation selections within the Choice enum; run locally so as to take the argument from result function
    func result( playerChoice: Choice){
           robotChat.text = ""
           let compChoice = Choice.allCases.randomElement()
       if playerChoice == compChoice{
            gameResultLabel.textColor = .black
            gameResultLabel.text = "DRAW!"
            robotChat.text = "ERRORERRORERRORERRORERRORERROR"
            showLabelandChat()
     } else if playerChoice == Choice.rock && compChoice == Choice.scissors || playerChoice == Choice.paper && compChoice == Choice.rock || playerChoice == Choice.scissors && compChoice == Choice.paper{
         compLabel(compChoice!)
            showLabelandChat()
            gameResultWin()
            aNewChallenger()
      } else {
            compLabel(compChoice!)
            showLabelandChat()
            gameResultLoss()
      }
   }
// step 1 - see line 11
    @IBAction func paperButtonPressed(_ sender: AnyObject) {
        paperSound.play()
        result(playerChoice: .paper)
        showResetButton()
    }
    
    @IBAction func rockButtonPressed(_ sender: AnyObject) {
        rockSound.play()
        result(playerChoice: .rock)
        showResetButton()
    }
    
    @IBAction func scissorsButtonPressed(_ sender: AnyObject) {
        scissorsSound.play()
        result(playerChoice: .scissors)
        showResetButton()
    }
    
    @IBAction func resetButtonPressed(_ sender: AnyObject) {
        comboBreaker.play()
        robotChat.text = ""
        robotImage.image = UIImage(named: "robot")
        hideLabelAndChat()
        hideResetButton()
    }
}
    
// QUESTIONS - is simplesound not intended for production? this prog does not have audio on actual hw
//           - how to compare the randomized case in a func?
    
    









