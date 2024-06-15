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
	
	let screenTitle: String
	let status: Status?
	
	init(status: Status?, screenTitle: String) {
		self.screenTitle = screenTitle
		self.status = status
		
		if let status {
			_games = Query(filter: #Predicate { $0.statusId == status.id})
		}
	}
	
	
	
	var body: some View {
		GameListView(games: games)
			.navigationTitle(screenTitle)
	}
}

#Preview {
	CategoryScreen(status: .onShelf, screenTitle: "Navigation Title")
		.modelContainer(previewContainer)
		.environment(GameViewModel())
}
