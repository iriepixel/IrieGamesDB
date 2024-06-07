//
//  GameModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 31/05/2024.
//

import Foundation

struct SearchGame: Identifiable, Codable, Hashable {
	var id = 0
	var name = ""
	var cover: Cover?
	var firstReleaseDate: TimeInterval? // Date(timeIntervalSince1970: TimeInterval(unixTime))
	var rating: Double?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case cover
		case rating
		case firstReleaseDate = "first_release_date"
	}
}

struct Cover: Codable, Hashable  {
	var imageId: String
	
	enum CodingKeys: String, CodingKey {
		case imageId = "image_id"
	}
}
