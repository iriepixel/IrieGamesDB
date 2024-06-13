//
//  GameListView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 11/06/2024.
//

import SwiftUI
import SwiftData

struct GameListView: View {
	
	@Environment(\.modelContext) private var modelContext
	@Environment(GameViewModel.self) var gameViewModel
	
	@Query private var libraryGames: [GameModel]
	
	var body: some View {
		List {
			ForEach(libraryGames) { libraryGame in
				NavigationLink(value: libraryGame) {
					Text(libraryGame.name)
				}
				.task {
					gameViewModel.selectedLibraryGame = libraryGame
				}
					.swipeActions {
						Button {
							modelContext.delete(libraryGame)
						} label: {
							Label("Delete", systemImage: "trash")
						}
						.tint(.red)
					}
			}
		}
		.navigationDestination(for: GameModel.self) { libraryGame in
//			GameScreen(game: libraryGame)
//			GameScreen(gameId: libraryGame.id)
			GameScreen()
		}
	}
}

#Preview {
	GameListView()
		.modelContainer(previewContainer)
		.environment(GameViewModel())
}
