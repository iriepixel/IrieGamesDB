//
//  CategoryScreen.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 15/06/2024.
//

import SwiftUI
import SwiftData

struct CategoryScreen: View {
	
	@Query private var games: [Game]
	
//	init(status: Status) {
//		print(status)
//		let predicate = #Predicate<Game> { game in
//			print(game.status)
//			game.status == status
//		}
//
//		_games = Query(filter: predicate, sort: \Game.name )
//	}
	
	var screenTitle: String
	
    var body: some View {
		GameListView(games: games)
			.navigationTitle(screenTitle)
    }
}

#Preview {
	CategoryScreen(screenTitle: "Navigation Title")
		.modelContainer(previewContainer)
		.environment(GameViewModel())
}
