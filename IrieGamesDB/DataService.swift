//
//  DataService.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 04/06/2024.
//

import Foundation
import SwiftUI
import SwiftData

struct DataService {
	
	private let clientId = Bundle.main.infoDictionary?["CLIENT_ID"] as? String
	private let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
	private let endpoint = "https://api.igdb.com/v4/games"
	
	func searchGames(query: String?) async -> [Game] {
		
		let rawBody = """
			search \"\(query!)\";
			  fields id, name, rating, first_release_date, summary,
				  cover.image_id,
				  platforms,
					  platforms.id,
					  platforms.name,
					  platforms.abbreviation,
						  platforms.platform_logo.id,
						  platforms.platform_logo.image_id,
				  screenshots,
					  screenshots.id,
					  screenshots.image_id,
				  involved_companies,
					  involved_companies.id,
					  involved_companies.developer,
					  involved_companies.company.name;
		"""
		
		// Create URL
		if let url = URL(string: endpoint) {
			
			// Create request
			var request = URLRequest(url: url)
			
			// Set request headers, method & body
			request.addValue(clientId!, forHTTPHeaderField: "Client-ID")
			request.addValue("Bearer \(apiKey!)", forHTTPHeaderField: "Authorization")
			request.httpMethod = "POST"
			request.httpBody = rawBody.data(using: .utf8)
			
			// Send request
			do {
				let (data, _) = try await URLSession.shared.data(for: request)
//				let (data, response) = try await URLSession.shared.data(for: request)
				
				// Parse JSON
				let decoder = JSONDecoder()
				let results = try decoder.decode([Game].self, from: data)
				return results
				
			} catch {
				print("Send request error [searchGames]: \(error)")
			}
			
		}
		
		return [Game]()
	}
	
	func fetchGameById(id: Int) async -> Game {
		let rawBody = """
			fields id, name, rating, first_release_date, summary,
				cover.image_id,
				platforms,
					platforms.id,
					platforms.name,
					platforms.abbreviation,
						platforms.platform_logo.id,
						platforms.platform_logo.image_id,
				screenshots,
					screenshots.id,
					screenshots.image_id,
				involved_companies,
					involved_companies.id,
					involved_companies.developer,
					involved_companies.company.name;
			where id = \(id);
		"""
		
		// Create URL
		if let url = URL(string: endpoint) {
			
			// Create request
			var request = URLRequest(url: url)
			request.addValue(clientId!, forHTTPHeaderField: "Client-ID")
			request.addValue("Bearer \(apiKey!)", forHTTPHeaderField: "Authorization")
			request.httpMethod = "POST"
			request.httpBody = rawBody.data(using: .utf8)
			
			// Send request
			do {
				let (data, _) = try await URLSession.shared.data(for: request)
				
//				print(String(decoding: data, as: UTF8.self))
				
				// Parse JSON
				let decoder = JSONDecoder()
				let responseGame = try decoder.decode([Game].self, from: data)
				
				let selectedGame = Game(
					id: responseGame[0].id,
					name: responseGame[0].name,
					cover: responseGame[0].cover,
					rating: responseGame[0].rating,
					firstReleaseDate: responseGame[0].firstReleaseDate,
					summary: responseGame[0].summary,
					platforms: responseGame[0].platforms,
					screenshots: responseGame[0].screenshots,
					involvedCompanies: responseGame[0].involvedCompanies
				)
				
//				print("Response Game Cover: \(String(describing: responseGame[0].cover))")
				
//				let newLibraryGame = LibraryGame(
//					id: responseGame[0].id,
//					name: responseGame[0].name,
//					cover: responseGame[0].cover,
//					rating: responseGame[0].rating,
//					firstReleaseDate: responseGame[0].firstReleaseDate,
//					summary: responseGame[0].summary,
//					platforms: responseGame[0].platforms,
//					screenshots: responseGame[0].screenshots,
//					involvedCompanies: responseGame[0].involvedCompanies
//				)
//				
//				modelContext.insert(newLibraryGame)
//				
				return selectedGame
				
			} catch {
				print("Send request error [searchGameById]: \(error)")
			}
			
		}
		
		return Game.example()
	}
}
