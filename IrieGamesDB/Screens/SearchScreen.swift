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
	
	@State private var gameNameQuery = ""
	
	var body: some View {
		
//		let game = viewModel.selectedLibraryGame
		
		NavigationStack {
			VStack {
				List{
					ForEach(viewModel.libraryGames) { game in
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
								
//								Button(action: {
//									modelContext.insert(game)
//								}) {
//									Image(systemName: "plus.circle")
//								}
//								.buttonStyle(BorderlessButtonStyle())
								
//								Spacer()
								
//								Button(action: {
//									viewModel.fetchGameById(id: game.id, modelContext: modelContext)
//									dismiss()
//								}) {
//									Image(systemName: "plus.circle")
//								}
//								.buttonStyle(BorderlessButtonStyle())	
							}
						}
						.task {
							viewModel.selectedLibraryGame = game
						}
					}
				}
				.navigationDestination(for: GameModel.self) { libraryGame in
					GameScreen()
				}
				.searchable(text: $gameNameQuery, prompt: "Enter game name to search ...")
				.navigationTitle("Search Games")
				.onSubmit(of: .search) {
					viewModel.fetchGamesByName(query: gameNameQuery)
				}
			}
		}
	}
}

//#Preview {
//	SearchScreen()
//		.modelContainer(for: [LibraryGame.self])
//}
