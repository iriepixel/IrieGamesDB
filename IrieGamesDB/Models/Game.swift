//
//  GameLibraryItemModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 04/06/2024.
//

import Foundation
import SwiftData

//enum Status: Int, Codable, Identifiable, CaseIterable {
//	case onShelf, inProgress, completed
//	var id: Self {
//		self
//	}
//	var descr: String {
//		switch self {
//		case .onShelf:
//			"On Shelf"
//		case .inProgress:
//			"In Progress"
//		case .completed:
//			"Completed"
//		}
//	}
//}

enum Status: Int, CaseIterable, Codable, Identifiable {
	var id: Int {
		rawValue
	}
	case onShelf = 1
	case inProgress
	case completed
}

extension Status {
	var name: String {
		switch self {
		case .onShelf:
			return "On Shelf"
		case .inProgress:
			return "In Progress"
		case .completed:
			return "Completed"
		}
	}
	var icon: String {
		switch self {
		case .onShelf:
			return "books.vertical"
		case .inProgress:
			return "play.square.stack"
		case .completed:
			return "checkmark.circle"
		}
	}
}

@Model
class Game: Identifiable, Codable, Hashable {
	
	var id = 0
	var name = ""
	//		var status: Status
	var status: Status {
		Status(rawValue: statusId)!
	}
	var statusId: Int
	var coverId: String?
	var cover: Cover?
	var rating: Double?
	var firstReleaseDate: TimeInterval? // Date(timeIntervalSince1970: TimeInterval(unixTime))
	var summary: String?
	var platforms: [Platform]?
	var screenshots: [Screenshot]?
	var involvedCompanies: [InvolvedCompany]?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case status
		case statusId
		case coverId = "image_id"
		case cover
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
		//		status: Status = .onShelf,
		status: Status,
		coverId: String?,
		cover: Cover?,
		rating: Double?,
		firstReleaseDate: TimeInterval?,
		summary: String?,
		platforms: [Platform]?,
		screenshots: [Screenshot]?,
		involvedCompanies: [InvolvedCompany]?
	) {
		self.id = id
		self.name = name
		//		self.status = status
		self.statusId = status.id
		self.coverId = coverId
		self.cover = cover
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
		//		status = try container.decodeIfPresent(Status.self, forKey: .status) ?? .onShelf
		statusId = try container.decodeIfPresent(Int.self, forKey: .statusId) ?? 1
		coverId = try container.decodeIfPresent(String.self, forKey: .coverId)
		cover = try container.decodeIfPresent(Cover.self, forKey: .cover)
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
	
	static func example() -> Game {
		let game = Game(
			id: 203722,
			name: "Dave the Diver",
			status: .onShelf,
			coverId: "co4v9d",
			cover: Cover(
				id: 834759,
				imageId: "co4v9d"
			),
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

struct Cover: Codable  {
	var id: Int?
	var imageId: String?
	
	enum CodingKeys: String, CodingKey {
		case id
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



