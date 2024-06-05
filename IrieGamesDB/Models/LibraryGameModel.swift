//
//  GameLibraryItemModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 04/06/2024.
//

import Foundation
import SwiftData

@Model
class LibraryGame: Identifiable, Codable {
	
	var id = 0
	var name = ""
	var cover: Cover?
	var rating: Double?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case cover
		case rating
	}
	
	init(id: Int, name: String, cover: Cover?, rating: Double?) {
		self.id = id
		self.name = name
		self.cover = cover
		self.rating = rating
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		cover = try container.decodeIfPresent(Cover.self, forKey: .cover)
		rating = try container.decodeIfPresent(Double.self, forKey: .rating)
	}
	
	func encode(to encoder: Encoder) throws {
		// TODO: Handle encoding if you need to here
	}
	
	struct Cover: Codable  {
		var imageId: String?
		
		enum CodingKeys: String, CodingKey {
			case imageId = "image_id"
		}
	}
}


