//
//  GameLibraryItemModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 04/06/2024.
//

import Foundation
import SwiftData

@Model
class LibraryGame: Identifiable, Codable, Hashable {
	
	var id = 0
	var name = ""
	var cover: Cover?
	var rating: Double?
	var firstReleseDate: TimeInterval? // Date(timeIntervalSince1970: TimeInterval(unixTime))
	var summary: String?
	var platforms: [Platform]?
	var screenshots: [Screenshot]?
	var involvedCompanies: [InvolvedCompany]?
	
//	summary, platforms, screenshots, involved_companies, game_modes, genres, similar_games, websites
//	player_perspectives, storyline
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case cover
		case rating
		case firstReleseDate = "first_release_date"
		case summary
		case platforms
		case screenshots
		case involvedCompanies = "involved_companies"
	}
	
	init(
		id: Int,
		name: String,
		cover: Cover?,
		rating: Double?,
		firstReleseDate: TimeInterval?,
		summary: String?,
		platforms: [Platform]?,
		screenshots: [Screenshot]?,
		involvedCompanies: [InvolvedCompany]?
	) {
		self.id = id
		self.name = name
		self.cover = cover
		self.rating = rating
		self.firstReleseDate = firstReleseDate
		self.summary = summary
		self.platforms = platforms
		self.screenshots = screenshots
		self.involvedCompanies = involvedCompanies
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		cover = try container.decodeIfPresent(Cover.self, forKey: .cover)
		rating = try container.decodeIfPresent(Double.self, forKey: .rating)
		firstReleseDate = try container.decodeIfPresent(TimeInterval.self, forKey: .firstReleseDate)
		summary = try container.decodeIfPresent(String.self, forKey: .summary)
		platforms = try container.decodeIfPresent([Platform].self, forKey: .platforms)
		screenshots = try container.decodeIfPresent([Screenshot].self, forKey: .screenshots)
		involvedCompanies = try container.decodeIfPresent([InvolvedCompany].self, forKey: .involvedCompanies)
	}
	
	func encode(to encoder: Encoder) throws {
		// TODO: Handle encoding if you need to here
	}
}

struct Platform: Codable, Identifiable  {
	var id: Int?
	var name: String?
	var abbreviation: String?
	var platformLogo: PlatformLogo?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case abbreviation
		case platformLogo = "platform_logo"
	}
}

struct PlatformLogo: Codable, Identifiable {
	var id: Int?
	var imageId: String?
	
	enum CodingKeys: String, CodingKey {
		case imageId = "image_id"
	}
}

struct Screenshot: Codable, Identifiable {
	var id: Int?
	var imageId: String?
	
	enum CodingKeys: String, CodingKey {
		case imageId = "image_id"
	}
}

struct InvolvedCompany: Codable, Identifiable {
	var id: Int?
	var company: Company?
	var developer: Bool?
	var publisher: Bool?
}

struct Company: Codable, Identifiable {
	var id: Int?
	var name: String?
}



