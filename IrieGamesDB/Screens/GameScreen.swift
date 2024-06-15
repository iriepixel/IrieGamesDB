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
	
	var game: Game
	
	var body: some View {
		
		ScrollView {
			GameDetailsView(game: game)
		}
		.onAppear {
			print("GameScreen onAppear: \(game.name) & \(game.status)")
			viewModel.selectedGame = game
		}
		.padding(.horizontal)
	}
}

#Preview {
	ModelPreview { game in
		GameScreen(game: game)
			.environment(GameViewModel())
	}
}

