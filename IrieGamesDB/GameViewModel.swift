//
//  GameViewModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 31/05/2024.
//

import Foundation
import Combine
import Alamofire

class GameViewModel: ObservableObject {
	@Published var games: [Game] = []

	private let baseURL = "https://api.igdb.com/v4/games"
	private let headers: HTTPHeaders = [
		"Client-ID": "xdkpe896gb9gap6e5ytng5e5ri4tjm",
		"Authorization": "Bearer jvmyyon8a6gachdn3suaedqka0f03d"
	]

	func searchGames(byName name: String) {
		let rawBody = "search \"\(name)\"; fields id,name,rating,cover.image_id; limit 100;"
		
		var request = URLRequest(url: URL(string: "https://api.igdb.com/v4/games")!)
		request.httpMethod = HTTPMethod.post.rawValue
		request.headers = headers
		request.httpBody = rawBody.data(using: .utf8)

		AF.request(request)
			.validate()
			.responseDecodable(of: [Game].self) { response in
				switch response.result {
				case .success(let games):
					DispatchQueue.main.async {
						self.games = games
					}
				case .failure(let error):
					print("Error fetching games: \(error.localizedDescription)")
				}
			}
	}
	
	func coverURL(for imageID: String) -> URL? {
		return URL(string: "https://images.igdb.com/igdb/image/upload/t_720p/\(imageID).jpg")
	}
}
