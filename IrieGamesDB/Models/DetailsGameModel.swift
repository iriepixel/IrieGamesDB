//
//  GameDetailModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 01/06/2024.
//

import Foundation

struct GameDetail: Identifiable, Codable {
	let id: Int
	let name: String
	let rating: Double?
	let summary: String?
	let artworks: [Artwork]?
	let cover: Cover?
	let genres: [Genre]?
	let screenshots: [Screenshot]?
	let platforms: [Platform]?
	let tags: [Tag]?

	struct Artwork: Codable {
		let image_id: String
	}

	struct Cover: Codable {
		let image_id: String
	}

	struct Genre: Codable {
		let id: Int
		let name: String
	}

	struct Screenshot: Codable {
		let image_id: String
	}

	struct Platform: Codable {
		let id: Int
		let name: String
	}

	struct Tag: Codable {
		let id: Int
		let name: String
	}
}
