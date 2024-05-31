//
//  LibraryGameModel.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 01/06/2024.
//

import Foundation
import SwiftData

@Model class LibraryGame: Identifiable {
	var id: Int
	var name: String
	var rating: Double?
	var coverURL: String

	init(id: Int, name: String, rating: Double?, coverURL: String) {
		self.id = id
		self.name = name
		self.rating = rating
		self.coverURL = coverURL
	}
}
