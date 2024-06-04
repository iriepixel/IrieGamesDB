//
//  DataService.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 04/06/2024.
//

import Foundation
import SwiftData
//import Alamofire
//import Combine

struct DataService {
	
	private let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
	private let endpoint = "https://api.igdb.com/v4/games"
	
	//	var searchGames = [SearchGame]()
	//	var libraryGames = [LibraryGame]()
	
	func searchGames(query: String?) async -> [SearchGame] {
		
		let rawBody = "search \"\(query!)\"; fields id,name,cover.image_id; limit 10;"
		
		// Create URL
		if let url = URL(string: endpoint) {
			
			// Create request
			var request = URLRequest(url: url)
			request.addValue("xdkpe896gb9gap6e5ytng5e5ri4tjm", forHTTPHeaderField: "Client-ID")
			request.addValue("Bearer \(apiKey!)", forHTTPHeaderField: "Authorization")
			request.httpMethod = "POST"
			request.httpBody = rawBody.data(using: .utf8)
			
			// Send request
			do {
				let (data, _) = try await URLSession.shared.data(for: request)
				
				print(data)
				
				// Parse JSON
				let decoder = JSONDecoder()
				let results = try decoder.decode([SearchGame].self, from: data)
				return results
				
			} catch {
				print("Send request error: \(error)")
			}
			
		}
		
		return [SearchGame]()
	}
	
	func searchGameById(id: Int, modelContext: ModelContext) async -> LibraryGame{
		
		let rawBody = "fields id,name,rating,cover.url,cover.image_id; where id = \(id);"
		
		// Create URL
		if let url = URL(string: endpoint) {
			
			// Create request
			var request = URLRequest(url: url)
			request.addValue("xdkpe896gb9gap6e5ytng5e5ri4tjm", forHTTPHeaderField: "Client-ID")
			request.addValue("Bearer \(apiKey!)", forHTTPHeaderField: "Authorization")
			request.httpMethod = "POST"
			request.httpBody = rawBody.data(using: .utf8)
			
			// Send request
			do {
				let (data, _) = try await URLSession.shared.data(for: request)
				
				// Parse JSON
				let decoder = JSONDecoder()
				let responseGame = try decoder.decode([LibraryGame].self, from: data)
				
				let newLibraryGame = LibraryGame(
					id: responseGame[0].id,
					name: responseGame[0].name,
					rating: responseGame[0].rating,
					cover: responseGame[0].cover
				)
				
				modelContext.insert(newLibraryGame)
				
				return newLibraryGame
				
			} catch {
				print("Send request error: \(error)")
			}
			
		}
		
		return LibraryGame(
			id: 0,
			name: "",
			rating: 0.0,
			cover: nil
		)
	}
}
