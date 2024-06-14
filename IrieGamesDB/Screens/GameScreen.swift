//
//  GameView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 05/06/2024.
//

import SwiftUI
import SwiftData

struct GameScreen: View {
	
	@Environment(\.modelContext) private var modelContext
	@Environment(GameViewModel.self) var viewModel
	
//	@State var gvm = GameViewModel()

	var game: Game
	
	var body: some View {
		
//		let game = viewModel.selectedLibraryGame
		
		ScrollView {
			GameView(game: game)
		}
		.padding(.horizontal)
	}
}

//#Preview {
//	ModelPreview { libraryGame in
//		GameScreen(libraryGame: libraryGame)
//			.environment(GameViewModel())
//	}
//}

