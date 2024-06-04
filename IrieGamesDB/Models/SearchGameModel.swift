//
//  GameModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 31/05/2024.
//

import Foundation

struct SearchGame: Codable, Identifiable {
	var id: Int
	var name: String
	var cover: Cover?
	var platforms: [Platform]?
	var firstReleseDate: TimeInterval? // Date(timeIntervalSince1970: TimeInterval(unixTime))
	var rating: Double?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case cover
		case platforms
		case rating
		case firstReleseDate = "first_release_date"
	}
}

struct Cover: Codable  {
	var imageId: String?
	
	enum CodingKeys: String, CodingKey {
		case imageId = "image_id"
	}
}

struct Platform: Codable  {
	var name: String?
	var platformLogo: PlatformLogo?
	
	enum CodingKeys: String, CodingKey {
		case name
		case platformLogo = "platform_logo"
	}
}

struct PlatformLogo: Codable {
	var imageId: String?
	
	enum CodingKeys: String, CodingKey {
		case imageId = "image_id"
	}
}

