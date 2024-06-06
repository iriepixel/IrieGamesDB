//
//  GameModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 31/05/2024.
//

import Foundation

struct SearchGame: Codable, Identifiable {
	var id = 0
	var name = ""
	var cover: Cover?
	var firstReleseDate: TimeInterval? // Date(timeIntervalSince1970: TimeInterval(unixTime))
	var rating: Double?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case cover
		case rating
		case firstReleseDate = "first_release_date"
	}
}

struct Cover: Codable, Identifiable, Hashable  {
	var id: String?
	var imageId: String?
	
	enum CodingKeys: String, CodingKey {
		case imageId = "image_id"
	}
}
