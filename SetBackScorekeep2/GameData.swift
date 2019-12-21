//
//  GameData.swift
//  SetBackScorekeep2
//
//  Created by Derek Shore on 12/14/19.
//  Copyright © 2019 Luxumbra. All rights reserved.
//

import Foundation


class Game {
	var team1Name: String
	var team2Name: String
	var team1Score: Int
	var team2Score: Int
	
	var currentBidder: RoundScoreMenu.Team
	var currentBidAmount: Int
	var currentRound: Int?
	
	init(team1Name: String, team2Name: String) {
		self.team1Name = team1Name
		self.team2Name = team2Name
		self.currentBidder = .team1
		self.currentBidAmount = 1
		self.team1Score = 0
		self.team2Score = 0
		self.currentRound = 1
	}
	
	func updateScore(team1Score: Int, team2Score: Int, round: Int){
		let team1OldScore = self.team1Score
		let team2OldScore = self.team2Score
		self.team1Score = team1OldScore+team1Score
		self.team2Score = team2OldScore+team2Score
	}
	
}

class RoundScoreType {
	var name: String
	var isSelected: Bool
	init(name: String, isSelected: Bool = false) {
		self.name = name
		self.isSelected = isSelected
	}
	func toggleSelection(){
		isSelected = !isSelected
	}
}

class RoundScoreMenu {
	enum Team: Int, CaseIterable {
		case team1, team2
	}
	var team1List = [
		RoundScoreType(name: "High"),
		RoundScoreType(name: "Low"),
		RoundScoreType(name: "Jack"),
		RoundScoreType(name: "Joker"),
		RoundScoreType(name: "Game"),
		RoundScoreType(name: "Shoot the Moon")
	]
	var team2List = [
		RoundScoreType(name: "High"),
		RoundScoreType(name: "Low"),
		RoundScoreType(name: "Jack"),
		RoundScoreType(name: "Joker"),
		RoundScoreType(name: "Game"),
		RoundScoreType(name: "Shoot the Moon")
	]
	
	func scoreMenu(for team: Team) -> [RoundScoreType] {
		switch team {
		case .team1:
			return team1List
		case .team2:
			return team2List
		}
	}
	
	func select(scoreTypeAt indexPath: IndexPath) {
		print("Section: \(indexPath.section), and row: \(indexPath.row)")
		if indexPath.section == 0 {
			team1List[indexPath.row].isSelected = !team1List[indexPath.row].isSelected
		} else {
			team2List[indexPath.row].isSelected = !team2List[indexPath.row].isSelected
		}
	}
	
	func totalScore(for team: Team) -> Int {
		switch  team{
		case .team1:
			if team1List.last!.isSelected {
				print("Someone shot the moon! Present as winner.")
				return 22
			}
			return team1List.filter { $0.isSelected == true }.count
		case .team2:
			if team2List.last!.isSelected {
				print("Someone shot the moon! Present as winner.")
				return 22
			}
			return team2List.filter { $0.isSelected == true }.count
		}
	}
	
	func resetSelections() {
		for item in team1List {
			item.isSelected = false
		}
		for item in team2List {
			item.isSelected = false
		}
	}
}
