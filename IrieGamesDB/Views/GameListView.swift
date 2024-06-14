//
//  GameListView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 14/06/2024.
//

import SwiftUI

struct GameListView: View {
	
	@Environment(\.modelContext) private var modelContext
	
	var games: [Game]
	
    var body: some View {
		VStack{
			if !games.isEmpty {
				List {
					ForEach(games) { game in
						NavigationLink(value: game) {
							Text(game.name)
						}
						.swipeActions {
							Button {
								modelContext.delete(game)
							} label: {
								Label("Delete", systemImage: "trash")
							}
							.tint(.red)
						}
					}
				}
				.navigationDestination(for: Game.self) { game in
					GameScreen(game: game)
				}
			} else {
				Text("This will be the list of games")
			}
		}
    }
}

//#Preview {
//    GameListView()
//		.modelContainer(previewContainer)
//		.environment(GameViewModel())
//}
