//
//  MainGameVC.swift
//  SetBackScorekeep2
//
//  Created by Derek Shore on 12/14/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit

class MainGameVC: UIViewController {

//	MARK: - VARIABLES
	var currentGame: Game?
	var currentRound = RoundScoreMenu()
	
//	MARK: - OUTLETS
	@IBOutlet weak var team1NameLabel: UILabel!
	@IBOutlet weak var team2NameLabel: UILabel!
	
	@IBOutlet weak var team1ScoreLabel: UILabel!
	@IBOutlet weak var team2ScoreLabel: UILabel!
	
	
	@IBOutlet weak var bidderOutlet: UISegmentedControl!
	@IBOutlet weak var currentBidOutlet: UISegmentedControl!
	
	@IBOutlet weak var postSetupStack: UIStackView!
	
	
//	MARK: - ACTIONS
	@IBAction func menuButton(_ sender: Any) {
		performSegue(withIdentifier: "ShowMenu", sender: self)
	}
	
	@IBAction func bidderSelection(_ sender: Any) {
		switch bidderOutlet.selectedSegmentIndex {
		case 0:
			currentGame?.currentBidder = .team1
		default:
			currentGame?.currentBidder = .team2
		}
		print("Winning bidder is: \(String(describing: currentGame?.currentBidder.rawValue))")
	}
	
	@IBAction func bidAmountSelection(_ sender: Any) {
		currentGame?.currentBidAmount = currentBidOutlet.selectedSegmentIndex + 1
		print("The current bid is: \(String(describing: currentGame?.currentBidAmount))")
	}
	
	@IBAction func scoreRound(_ sender: Any) {
		performSegue(withIdentifier: "ShowScoreTable", sender: self)
	}
	
	@IBAction func scoreTeam1(_ sender: Any) {
		performSegue(withIdentifier: "ScoreTeam1", sender: self)
	}
	
	@IBAction func scoreTeam2(_ sender: Any) {
		performSegue(withIdentifier: "ScoreTeam2", sender: self)
	}

	
//	MARK: - OVERRIDES
	override func viewDidLoad() {
        super.viewDidLoad()
		if currentGame == nil {
			postSetupStack.isHidden = true
		} else {
			postSetupStack.isHidden = false
		}
        // Do any additional setup after loading the view.
    }
    
//	MARK: - Functions
	func updateBidderSwitch(with game: Game) {
		bidderOutlet.removeAllSegments()
		bidderOutlet.insertSegment(withTitle: game.team1Name, at: 0, animated: true)
		bidderOutlet.insertSegment(withTitle: game.team2Name, at: 1, animated: true)
		bidderOutlet.selectedSegmentIndex = 0
		bidderSelection(self)
	}
	
	
    
//	MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
		switch segue.identifier {
		case "ShowMenu":
			let vc = segue.destination as! TeamNameVC
			vc.delegate = self
		case "ShowScoreTable":
			let vc = segue.destination as! ScoreTableTVC
			vc.delegate = self
			vc.round = currentGame?.currentRound
			vc.team1Name = currentGame!.team1Name
			vc.team2Name = currentGame!.team2Name
		default:
			print("error with segue identifier from MainGameVC")
		}
    }
    

}

extension MainGameVC: TeamNameDelegate {
	func teamNameDelegate(team1Name: String, team2Name: String) {
		currentGame = Game(team1Name: team1Name, team2Name: team2Name)
		team1NameLabel.text = team1Name
		team2NameLabel.text = team2Name
		updateBidderSwitch(with: currentGame!)
		currentBidOutlet.selectedSegmentIndex = 0
		postSetupStack.isHidden = false
	}
	
	
}

extension MainGameVC: ScoreTableDelegate {
	func scoreTableDelegate(team1Score: Int, team2Score: Int, round: Int) {
		currentGame?.updateScore(team1Score: team1Score, team2Score: team2Score, round: round)
		team1ScoreLabel.text = currentGame?.team1Score.description
		team2ScoreLabel.text = currentGame?.team2Score.description
		currentGame?.currentRound! += 1
	}
	
	
}
