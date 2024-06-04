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
	
	var searchGames = [SearchGame]()
	var dataService = DataService()
//	var selectedGame: LibraryGame?
	
	func getGames(query: String?) {
		Task {
			searchGames = await dataService.searchGames(query: query)
		}
	}
	
	func addGame(id: Int, modelContext: ModelContext) {
		Task {
			await dataService.searchGameById(id: id, modelContext: modelContext)
		}
	}

	func coverURL(for imageId: String) -> URL? {
		return URL(string: "https://images.igdb.com/igdb/image/upload/t_720p/\(imageId).jpg")
	}
}
	
