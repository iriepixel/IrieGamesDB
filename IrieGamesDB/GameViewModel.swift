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
	var dataService = DataService()
	
	func getGames(query: String?) {
		Task {
			searchGames = await dataService.searchGames(query: query)
		}
	}
	
	func fetchGameById(id: Int, modelContext: ModelContext) {
//		let fetchGameByIdTask = Task { () -> LibraryGame in
//			return await dataService.fetchGameById(id: id)
//		}
		Task {
			return await dataService.fetchGameById(id: id, modelContext: modelContext)
		}
	}
	
	func coverURL(for imageId: String) -> URL? {
		return URL(string: "https://images.igdb.com/igdb/image/upload/t_720p/\(imageId).jpg")
	}
}

