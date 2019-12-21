//
//  ScoreButtonsVC.swift
//  SetBackScorekeep2
//
//  Created by Derek Shore on 12/15/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit

class ScoreButtonsVC: UIViewController {
	
	var currentGame: Game?
	var bidder: RoundScoreMenu.Team?
	var scoreMenu = RoundScoreMenu()
	var scoreItemA: RoundScoreType?
	var scoreItemB: RoundScoreType?

	@IBOutlet weak var team1Name: UILabel!
	@IBOutlet weak var team1Score: UILabel!
	@IBOutlet weak var team2Name: UILabel!
	@IBOutlet weak var team2Score: UILabel!
	
	
	@IBAction func highButton(_ sender: UIButton) {
		scoreItemA = scoreMenu.team1List[0]
		scoreItemB = scoreMenu.team2List[0]
		if sender.tag == 1 {
			scoreItemA?.isSelected = true
			scoreItemB?.isSelected = false
		} else {
			scoreItemA?.isSelected = false
			scoreItemB?.isSelected = true
		}
	}
	@IBAction func lowButton(_ sender: UIButton) {
	}
	@IBAction func jackButton(_ sender: UIButton) {
	}
	@IBAction func jokerButton(_ sender: UIButton) {
	}
	@IBAction func gameButton(_ sender: UIButton) {
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		if bidder == .team1 {
			team1Name.textColor = .green
			team2Name.textColor = .black
		} else {
			team1Name.textColor = .black
			team2Name.textColor = .green
		}
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
