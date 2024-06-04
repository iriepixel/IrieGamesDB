//
//  GameModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 31/05/2024.
//

import Foundation

struct SearchGame: Identifiable, Codable {
	let id: Int
	let name: String
	let rating: Double?
	let cover: Cover?

	struct Cover: Codable {
		let image_id: String
	}
}
