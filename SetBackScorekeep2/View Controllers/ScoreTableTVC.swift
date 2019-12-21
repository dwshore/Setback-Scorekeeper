//
//  ScoreTableTVC.swift
//  SetBackScorekeep2
//
//  Created by Derek Shore on 12/15/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit

protocol ScoreTableDelegate {
	func scoreTableDelegate(team1Score: Int, team2Score: Int, round: Int)
}

class ScoreTableTVC: UITableViewController {
	
	var team1Name = "Team 1"
	var team2Name = "Team 2"
	var team1List = RoundScoreMenu().team1List
	var team2List = RoundScoreMenu().team2List
	
	var team1RoundScore: Int = 0
	var team2RoundScore: Int = 0
	
	var round: Int?
	var delegate: ScoreTableDelegate?
	
	func configureCell(cell: UITableViewCell, item: RoundScoreType){
		cell.textLabel!.text = item.name
		if item.isSelected {
			cell.accessoryType = .checkmark
		} else {
			cell.accessoryType = .none
		}
		
	}
	
	func tallyScore(_ section: Int){
		if section == 0 {
			team1RoundScore = team1List.filter {$0.isSelected == true}.count
		} else {
			team2RoundScore = team2List.filter {$0.isSelected == true}.count
		}
	}
	

	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.allowsSelection = true
		tableView.isUserInteractionEnabled = true
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		delegate?.scoreTableDelegate(team1Score: team1RoundScore, team2Score: team2RoundScore, round: round!)
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return team1Name + ": " + String(team1RoundScore.description)
		} else {
			return team2Name + ": " + String(team2RoundScore.description)
		}
	}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
		if indexPath.section == 0 {
			configureCell(cell: cell, item: team1List[indexPath.row])
		} else {
			configureCell(cell: cell, item: team2List[indexPath.row])
		}
        return cell
    }
    
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.cellForRow(at: indexPath)?.isSelected = true
		print("Section: \(indexPath.section), row: \(indexPath.row)")
		if indexPath.section == 0 {
			team1List[indexPath.row].toggleSelection()
		} else {
			team2List[indexPath.row].toggleSelection()
		}
		tallyScore(indexPath.section)
		tableView.reloadData()
	}

}
