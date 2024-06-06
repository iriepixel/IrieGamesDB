//
//  SearchView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 03/06/2024.
//

import SwiftUI

struct SearchView: View {
	
	@Environment(GameViewModel.self) var viewModel
	@Environment(\.modelContext) private var modelContext
	
	@Environment(\.dismissSearch) private var dismissSearch
	@Environment(\.dismiss) private var dismiss
	
	@State private var searchText = ""
	
	var body: some View {
		VStack {
			List(viewModel.searchGames) { game in
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
						
//						HStack {
//							if let firstReleseDate = game.rating {
//								Text(Helpers.getReleaseDate(unixTime: firstReleseDate))
//									.font(.caption)
//									.foregroundColor(.gray)
//							}
//							
//							if let rating = game.rating {
//								Text("Rating: \(Int(rating))")
//									.font(.caption)
//									.foregroundColor(.gray)
//							}
//						}
					}
					
					Spacer()
					
					Button(action: {
						viewModel.fetchGameById(id: game.id, modelContext: modelContext)
						dismiss()
					}) {
						Image(systemName: "plus.circle")
					}
					.buttonStyle(BorderlessButtonStyle())
					
				}
			}
//			.listStyle(.plain)
			.searchable(text: $searchText, prompt: "Search for a game...")
			.navigationTitle("Search Games")
//			.navigationBarTitleDisplayMode(.inline)
			.onSubmit(of: .search) {
//				dismissSearch()
//				dismiss()
				viewModel.getGames(query: searchText)
			}
		}
	}
}
//
//#Preview {
//	SearchView()
//}
