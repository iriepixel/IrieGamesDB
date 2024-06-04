//
//  SearchView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 03/06/2024.
//

import SwiftUI

struct SearchView: View {
	
	@Environment(GameViewModel.self) var model
	@Environment(\.modelContext) private var modelContext
	@State private var searchText = ""
	
	var body: some View {
		VStack {
			List(model.searchGames) { game in
				HStack(spacing: 15) {
					if let imageId = game.cover?.imageId {
						let url = model.coverURL(for: imageId)
						
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
						
						HStack {
							if let firstReleseDate = game.rating {
								Text(Helpers.getReleaseDate(unixTime: firstReleseDate))
									.font(.caption)
									.foregroundColor(.gray)
							}
							
							if let rating = game.rating {
								Text("Rating: \(Int(rating))")
									.font(.caption)
									.foregroundColor(.gray)
							}
						}
					}
					
					Spacer()
					
					Button(action: {
						model.addGame(id: game.id, modelContext: modelContext)
					}) {
						Image(systemName: "plus.circle")
					}
					.buttonStyle(BorderlessButtonStyle())
					
				}
			}
			.navigationTitle("Search Games")
			.searchable(text: $searchText, prompt: "Search for a game...")
			.onSubmit(of: .search) {
				model.getGames(query: searchText)
			}
		}
	}
}
//
//#Preview {
//	SearchView()
//}
