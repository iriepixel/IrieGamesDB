//
//  DataService.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 04/06/2024.
//

import Foundation
//import Alamofire
//import Combine

struct DataService {
	
	private let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
	private let baseURL = "https://api.igdb.com/v4/games"
	
	var games = [Game]()
	
	func searchGames(query: String?) async -> [Game] {
		
		//		// Check API key exists
		//		guard apiKey != nil else {
		//			return [Game]()
		//		}
		//
//		let headers: HTTPHeaders = [
//			"Client-ID": "xdkpe896gb9gap6e5ytng5e5ri4tjm",
//			"Authorization": "Bearer \(apiKey!)"
//		]
		
//		var request = URLRequest(url: URL(string: baseURL)!)
		let rawBody = "search \"\(query!)\"; fields id,name,rating,cover.image_id; limit 100;"
		
//		request.httpMethod = HTTPMethod.post.rawValue
//		request.headers = headers
//		request.httpBody = rawBody.data(using: .utf8)
		
		// Create URL
//		if let url = URL(string: endpointUrlString) {
			
			// Create request
			var request = URLRequest(url: URL(string: baseURL)!)
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
				let results = try decoder.decode([Game].self, from: data)
				return results
				
			} catch {
				print("Send request error: \(error)")
			}
			
//		}
		
		
		//		let AFRequest = AF.request(request)
		//		AFRequest.responseDecodable(of: [Game].self) { response in
		//			switch response.result {
		//				   case .success(let games):
		//				   DispatchQueue.main.async {
		//					   self.games = games
		//				   }
		//				   case .failure(let error):
		//					   print("Error fetching games: \(error.localizedDescription)")
		//			   }
		//		   }
		
		return [Game]()
	}
}
