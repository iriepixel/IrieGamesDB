//
//  GameLibraryItemModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 04/06/2024.
//

import Foundation
import SwiftData

@Model
class GameLibraryItemModel: Codable {
	var id: Int
	var name: String
	var rating: Double?
	let cover: Cover?

	init(id: Int, name: String, rating: Double?, cover: Cover?) {
		self.id = id
		self.name = name
		self.rating = rating
		self.cover = cover
	}

	// MARK: - Codable Conformance
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		rating = try container.decodeIfPresent(Double.self, forKey: .rating)
		cover = try container.decodeIfPresent(Cover.self, forKey: .cover)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(name, forKey: .name)
		try container.encodeIfPresent(rating, forKey: .rating)
		try container.encodeIfPresent(cover, forKey: .cover)
	}

	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case rating
		case cover
	}
	
	struct Cover: Codable {
		let image_id: String?
	}
}

