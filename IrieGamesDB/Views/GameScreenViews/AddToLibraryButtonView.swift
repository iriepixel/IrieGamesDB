//
//  AddToLibraryView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 14/06/2024.
//

import SwiftUI

struct AddToLibraryButtonView: View {
	
	@Environment(\.modelContext) private var modelContext
	@Environment(GameViewModel.self) var viewModel
	
	var game: Game
	
    var body: some View {
		Button(action: {
			let gameToSave = Game(
				id: game.id,
				name: game.name,
				coverId: game.cover?.imageId,
				cover: game.cover,
				rating: game.rating,
				firstReleaseDate: game.firstReleaseDate,
				summary: game.summary,
				platforms: game.platforms,
				screenshots: game.screenshots,
				involvedCompanies: game.involvedCompanies
			)
			
//			let gameIdToSave = gameToSave.id
			
			modelContext.insert(gameToSave)
		}) {
			Image(systemName: "plus.circle")
		}
		.buttonStyle(BorderlessButtonStyle())
    }
}

//#Preview {
//	AddToLibraryButtonView()
//}
