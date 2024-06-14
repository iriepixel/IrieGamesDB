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
	var selectedGame: Game?
	
	var webService = WebService()
	
	func getGames(query: String?) {
		Task {
			games = await webService.searchGames(query: query)
		}
	}
	
	func fetchGameById(id: Int) {
		Task {
			selectedGame = await webService.fetchGameById(id: id)
		}
	}
	
	func setSelectedGame(game: Game) {
		selectedGame = game
	}
	
	func coverURL(imageId: String) -> URL? {
//		print(imageId)
		return URL(string: "https://images.igdb.com/igdb/image/upload/t_720p/\(imageId).jpg")
	}
}

