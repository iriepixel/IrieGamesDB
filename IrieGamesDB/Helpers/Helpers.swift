//
//  Helpers.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 04/06/2024.
//

import Foundation

struct Helpers {
	
	static func getReleaseDate(unixTime: TimeInterval) -> String {
				
		let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy" // Specify date format
		let dateString = dateFormatter.string(from: date)
		
		return dateString
	}
}
