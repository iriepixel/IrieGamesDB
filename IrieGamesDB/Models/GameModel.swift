//
//  GameLibraryItemModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 04/06/2024.
//

import Foundation
import SwiftData

extension GameModel {
	enum Status: String, CaseIterable, Codable, Hashable {
		case backlog = "Backlog"
		case playing = "Playing"
		case complete = "Complete"
	}
}

//enum Status: String, CaseIterable, Codable, Hashable {
//	case backlog = "Backlog"
//	case playing = "Playing"
//	case complete = "Complete"
//}

//@Model
//class Status {
//	var name: String = ""
//	
//	var products: [Product]?
//	
//	init(
//		name: String
//	) {
//		self.name = name
//		self.products = []
//	}
//}

@Model
class GameModel: Identifiable, Codable, Hashable {
	
	var id = 0
	var name = ""
	var cover: Cover?
//	var status: Status = Status.backlog
	var status: Status
	var rating: Double?
	var firstReleaseDate: TimeInterval? // Date(timeIntervalSince1970: TimeInterval(unixTime))
	var summary: String?
	var platforms: [Platform]?
	var screenshots: [Screenshot]?
	var involvedCompanies: [InvolvedCompany]?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case cover
		case status
		case rating
		case firstReleaseDate = "first_release_date"
		case summary
		case platforms
		case screenshots
		case involvedCompanies = "involved_companies"
	}
	
	init(
		id: Int,
		name: String,
		cover: Cover?,
		status: Status = Status.backlog,
		rating: Double?,
		firstReleaseDate: TimeInterval?,
		summary: String?,
		platforms: [Platform]?,
		screenshots: [Screenshot]?,
		involvedCompanies: [InvolvedCompany]?
	) {
		self.id = id
		self.name = name
		self.cover = cover
		self.status = status
		self.rating = rating
		self.firstReleaseDate = firstReleaseDate
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
		status = Status.backlog
		rating = try container.decodeIfPresent(Double.self, forKey: .rating)
		firstReleaseDate = try container.decodeIfPresent(TimeInterval.self, forKey: .firstReleaseDate)
		summary = try container.decodeIfPresent(String.self, forKey: .summary)
		platforms = try container.decodeIfPresent([Platform].self, forKey: .platforms)
		screenshots = try container.decodeIfPresent([Screenshot].self, forKey: .screenshots)
		involvedCompanies = try container.decodeIfPresent([InvolvedCompany].self, forKey: .involvedCompanies)
	}
	
	func encode(to encoder: Encoder) throws {
		// TODO: Handle encoding if you need to here
	}
	
	static func example() -> GameModel {
		let game = GameModel(
			id: 203722,
			name: "Dave the Diver",
			cover: Cover(
				imageId: "co4v9d"
			),
			status: Status.backlog,
			rating: 81.56281059032352,
			firstReleaseDate: 1666828800,
			summary: "Marine adventure set in the mysterious Blue Hole. Explore the sea with Dave by day, and run a sushi restaurant at night. Uncover the secrets of the Blue Hole, and unwrap this deep sea mystery involving three friends, each with distinct personalities. New adventures await.",
			platforms: [
				Platform(
					abbreviation: "PS5"
				),
				Platform(
					abbreviation: "Switch"
				),
				Platform(
					abbreviation: "PC"
				)
			],
			screenshots: [
				Screenshot(
					id: 806758,
					imageId: "schahy"
				),
				Screenshot(
					id: 806759,
					imageId: "schahz"
				),
				Screenshot(
					id: 806760,
					imageId: "schai0"
				),
			],
			involvedCompanies: [
				InvolvedCompany(
					company: Company(
						name: "MINTROCKET"
					),
					developer: true,
					publisher: false
				)
			]
		)
		
		return game
	}
}

struct Cover: Codable, Hashable  {
	var imageId: String
	
	enum CodingKeys: String, CodingKey {
		case imageId = "image_id"
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
	var id: Int
	var imageId: String
	
	enum CodingKeys: String, CodingKey {
		case id
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



