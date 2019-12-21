//
//  ScoringTVC.swift
//  SetBackScorekeep2
//
//  Created by Derek Shore on 12/15/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import UIKit
protocol ScoringDelegate {
	func scoringDelegate(update score: Int, for selectedTeam: Game.Teams)
}
class ScoringTVC: UITableViewController {

	
	var menu = RoundScoreMenu()
	var delegate: ScoringDelegate?
	var selectedTeam: Game.Teams?
	var team1Name: String?
	var team2Name: String?
	
	func configureCell(cell: UITableViewCell, indexPath: IndexPath) {
		var list: [RoundScoreType]
		var listItem: RoundScoreType
		
		if selectedTeam == .team1 {
			list = menu.scoreMenu(for: .team1)
			listItem = list[indexPath.row]
		} else {
			list = menu.scoreMenu(for: .team2)
			listItem = list[indexPath.row]
		}
		
		cell.textLabel!.text = listItem.name
		if listItem.isSelected {
			cell.accessoryType = .checkmark
		} else {
			cell.accessoryType = .none
		}
	}
	
	func toggleCheckMark(indexPath: IndexPath){
		if selectedTeam == .team1 {
			menu.team1List[indexPath.row].isSelected = !menu.team1List[indexPath.row].isSelected
		} else {
			menu.team2List[indexPath.row].isSelected = !menu.team2List[indexPath.row].isSelected
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

	
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return menu.scoreMenu(for: .team1).count
    }

/*
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return team1Name
		} else {
			return team2Name
		}
	}
*/
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
		tableView.allowsSelection = true
		configureCell(cell: cell, indexPath: indexPath)
		
        return cell
    }
    
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Section: \(indexPath.section), row: \(indexPath.row)")
		/*
		if selectedTeam == .team1 {
			menu.team1List[indexPath.row].isSelected = !menu.team1List[indexPath.row].isSelected
		} else {
			menu.team2List[indexPath.row].isSelected = !menu.team2List[indexPath.row].isSelected
		}
		tableView.deselectRow(at: indexPath, animated: true)
//		let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
//		configureCell(cell: cell, indexPath: indexPath)
//		tableView.reloadRows(at: [indexPath], with: .automatic)
		*/
	}
}
