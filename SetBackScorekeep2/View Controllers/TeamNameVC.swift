//
//  TeamNameVC.swift
//  SetBackScorekeep2
//
//  Created by Derek Shore on 12/14/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit

protocol TeamNameDelegate {
	func teamNameDelegate(team1Name: String, team2Name: String)
}

class TeamNameVC: UIViewController {

	var delegate: TeamNameDelegate?
	var team1Name: String = "Salsa"
	var team2Name: String = "Pickles"
	@IBOutlet weak var Team1TextField: UITextField!
	@IBOutlet weak var Team2TextField: UITextField!
	@IBOutlet weak var doneOutlet: UIButton!
	
	@IBAction func doneButton(_ sender: Any) {
		passTeamNames()
	}
	
	
	func passTeamNames(){
		if !Team1TextField.text!.isEmpty {
			team1Name = Team1TextField.text!
		}
		if !Team2TextField.text!.isEmpty {
			team2Name = Team2TextField.text!
		}
		
		delegate?.teamNameDelegate(team1Name: team1Name, team2Name: team2Name)
		dismiss(animated: true)
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
	override func viewWillAppear(_ animated: Bool) {
		Team1TextField.becomeFirstResponder()
	}
	override func viewWillDisappear(_ animated: Bool) {
		passTeamNames()
	}
}

