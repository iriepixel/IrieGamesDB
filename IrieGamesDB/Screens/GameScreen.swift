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
	
//	@State var gvm = GameViewModel()
	
//	var gameId: Int
//	@State var game = GameViewModel().selectedLibraryGame
	var game: Game
	
	var body: some View {
		
//		let game = viewModel.selectedLibraryGame
		
		ScrollView {
			VStack(spacing: 20) {
//				if let game = game {
					
					Button(action: {
						modelContext.insert(game)
						try?  modelContext.save()
					}) {
						Image(systemName: "plus.circle")
					}
					.buttonStyle(BorderlessButtonStyle())
					
					if let imageId = game.cover?.imageId {
						let url = viewModel.coverURL(imageId: imageId)
						
						AsyncImage(url: url) { image in
							image
								.resizable()
								.aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
						} placeholder: {
							ProgressView()
						}
						.frame(width: 300, height: 500)
						.clipShape(RoundedRectangle(cornerRadius: 5))
					} else {
						GameCoverPlaceholderView()
					}
					
					Text(game.name)
						.font(.largeTitle)
						.bold()
					
					if let rating = game.rating {
						Text("Rating: \(Int(rating))")
					}
					
					if let firstReleseDate = game.firstReleaseDate {
						Text(Helpers.getReleaseDate(unixTime: firstReleseDate))
					}
					
					if let summary = game.summary {
						Text(summary)
					}
					
					if let platforms = game.platforms {
						ForEach(platforms) {platform in
							//						Text(platform.name ?? "N/A")
							Text(platform.abbreviation ?? "N/A")
							
							//						if let imageId = platform.platformLogo?.imageId {
							//							let url = viewModel.coverURL(imageId: imageId)
							//
							//							AsyncImage(url: url) { image in
							//								image
							//									.resizable()
							//									.aspectRatio(contentMode: .fit)
							//							} placeholder: {
							//								ProgressView()
							//							}
							//							.frame(width: 50, height: 50)
							//							.clipShape(RoundedRectangle(cornerRadius: 5))
							//						} else {
							//							GameCoverPlaceholderView()
							//						}
						}
					}
					
					if let screenshots = game.screenshots {
						ForEach(screenshots) { screenshot in
							let url = viewModel.coverURL(imageId: screenshot.imageId)
							
							AsyncImage(url: url) { image in
								image
									.resizable()
									.aspectRatio(contentMode: .fill)
							} placeholder: {
								ProgressView()
							}
							.frame(width: 360, height: 220)
							.clipShape(RoundedRectangle(cornerRadius: 5))
						}
					}
					
					if let involvedCompanies = game.involvedCompanies {
						ForEach(involvedCompanies) {involvedCompany in
							Text((involvedCompany.company?.name)!)
						}
					}
//				}
			}
		}
		.padding(.horizontal)
		.onAppear {
//			viewModel.fetchGameById(id: gameId)
		}
		.onDisappear(perform: {
//			viewModel.selectedLibraryGame = nil
		})
	}
}

//#Preview {
//	ModelPreview { libraryGame in
//		GameScreen(libraryGame: libraryGame)
//			.environment(GameViewModel())
//	}
//}

