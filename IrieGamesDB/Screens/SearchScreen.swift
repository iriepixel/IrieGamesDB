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
				List{
					ForEach(viewModel.games) { game in
						NavigationLink(value: game) {
							HStack(spacing: 15) {
								if let imageId = game.cover?.imageId {
									let url = viewModel.coverURL(imageId: imageId)
									
									AsyncImage(url: url) { image in
										image
											.resizable()
											.aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
									} placeholder: {
										ProgressView()
									}
									.frame(width: 80, height: 107)
									.clipShape(RoundedRectangle(cornerRadius: 5))
								} else {
									GameCoverPlaceholderView()
								}
								
								VStack(alignment: .leading) {
									Text(game.name)
										.font(.subheadline)
										.bold()
								}
							}
						}
					}
				}
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

//#Preview {
//	SearchScreen()
//		.modelContainer(for: [LibraryGame.self])
//}
