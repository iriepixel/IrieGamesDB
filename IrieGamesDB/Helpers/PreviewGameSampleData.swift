//
//  PreviewGameSampleData.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 06/06/2024.
//

import Foundation
import SwiftData

let previewContainer: ModelContainer = {
	
	do {
		let config = ModelConfiguration(isStoredInMemoryOnly: true)
		let container = try ModelContainer(for: LibraryGame.self, configurations: config)
		
		Task { @MainActor in
			let context = container.mainContext
			
			let game = LibraryGame.example()
			context.insert(game)
		}
		
		return container
		
	} catch {
		fatalError("Failed to create container with error: \(error.localizedDescription)")
	}
}()

