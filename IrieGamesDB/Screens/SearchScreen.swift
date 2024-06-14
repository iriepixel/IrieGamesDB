//
//  SearchView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 03/06/2024.
//

import SwiftUI

struct SearchScreen: View {
	
	@Environment(\.modelContext) private var modelContext
	@Environment(GameViewModel.self) var viewModel
	
	@Environment(\.dismissSearch) private var dismissSearch
	@Environment(\.dismiss) private var dismiss
	
	@State private var searchText = ""
	
	var body: some View {
		NavigationStack {
			VStack {
				SearchGameListView()
				.navigationDestination(for: Game.self) { game in
					GameScreen(game: game)
				}
				.searchable(text: $searchText, prompt: "Search for a game...")
				.navigationTitle("Search Games")
				.onSubmit(of: .search) {
					viewModel.getGames(query: searchText)
				}
			}
		}
	}
}

#Preview {
	SearchScreen()
		.modelContainer(for: [Game.self])
}
