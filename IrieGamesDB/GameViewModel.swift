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
	
	var searchGames = [SearchGame]()
	var selectedLibraryGame: LibraryGame?
	
	var dataService = DataService()
	
	func getGames(query: String?) {
		Task {
			searchGames = await dataService.searchGames(query: query)
		}
	}
	
	func fetchGameById(id: Int, modelContext: ModelContext) {
		Task {
			return await dataService.fetchGameById(id: id, modelContext: modelContext)
		}
	}
	
	func coverURL(imageId: String) -> URL? {
		print(imageId)
		return URL(string: "https://images.igdb.com/igdb/image/upload/t_720p/\(imageId).jpg")
	}
}

