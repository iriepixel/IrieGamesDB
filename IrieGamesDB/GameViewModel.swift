//
//  GameViewModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 31/05/2024.
//

import Foundation
import SwiftData

@Observable
class GameViewModel: ObservableObject {
	
	var games = [Game]()
	var selectedLibraryGame: Game?
	var selectedGameId: Int?
	
	var dataService = DataService()
	
	func getGames(query: String?) {
		Task {
			games = await dataService.searchGames(query: query)
		}
	}
	
	func fetchGameById(id: Int) {
		Task {
			selectedLibraryGame = await dataService.fetchGameById(id: id)
		}
	}
	
	func setSelectedGame(game: Game) {
		print(game.name)
		selectedLibraryGame = game
	}
	
	func coverURL(imageId: String) -> URL? {
//		print(imageId)
		return URL(string: "https://images.igdb.com/igdb/image/upload/t_720p/\(imageId).jpg")
	}
}

