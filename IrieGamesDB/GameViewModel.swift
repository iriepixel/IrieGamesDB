//
//  GameViewModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 31/05/2024.
//

import Foundation

@Observable
class GameViewModel: NSObject {
	
	var games = [Game]()
	var dataService = DataService()
	
	func getGames(query: String?) {
		Task {
			games = await dataService.searchGames(query: query)
		}
	}

	func coverURL(for imageID: String) -> URL? {
		return URL(string: "https://images.igdb.com/igdb/image/upload/t_720p/\(imageID).jpg")
	}
}
	
