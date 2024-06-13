//
//  GameViewModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 31/05/2024.
//

import Foundation
import SwiftData

@Observable
class GameViewModel {
	
//	var searchGames = [SearchGame]()
	var libraryGames = [GameModel]()
	var selectedLibraryGame: GameModel?
	var selectedGameId: Int?
	
	var dataService = WebService()
	
	func fetchGamesByName(query: String?) {
		Task {
			libraryGames = await dataService.fetchGamesByName(query: query)
		}
	}
	
	func fetchGameById(id: Int) {
		Task {
			selectedLibraryGame = await dataService.fetchGameById(id: id)
		}
	}
	
	func coverURL(imageId: String) -> URL? {
		print(imageId)
		return URL(string: "https://images.igdb.com/igdb/image/upload/t_720p/\(imageId).jpg")
	}
}

