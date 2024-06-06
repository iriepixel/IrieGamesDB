//
//  GameView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 05/06/2024.
//

import SwiftUI
import SwiftData

struct GameScreen: View {
	
	@Environment(GameViewModel.self) var viewModel
	let libraryGame: LibraryGame
	
	var body: some View {
		ScrollView {
			VStack {
				Text(libraryGame.name)
				
				if let imageId = libraryGame.cover?.imageId {
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
				
				//				Text((game.cover?.imageId) ?? "N/A")
				
				if let rating = libraryGame.rating {
					Text("Rating: \(Int(rating))")
				}
				
				if let firstReleseDate = libraryGame.firstReleseDate {
					Text(Helpers.getReleaseDate(unixTime: firstReleseDate))
				}
				
				if let summary = libraryGame.summary {
					Text(summary)
				}
				
				if let platforms = libraryGame.platforms {
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
				
				if let screenshots = libraryGame.screenshots {
					ForEach(screenshots) { screenshot in
						if let imageId = screenshot.imageId {
							let url = viewModel.coverURL(imageId: imageId)
							
							AsyncImage(url: url) { image in
								image
									.resizable()
									.aspectRatio(contentMode: .fill)
							} placeholder: {
								ProgressView()
							}
							.frame(width: 200, height: 150)
							.clipShape(RoundedRectangle(cornerRadius: 5))
						} else {
							GameCoverPlaceholderView()
						}
						
					}
				}
				
				if let involvedCompanies = libraryGame.involvedCompanies {
					ForEach(involvedCompanies) {involvedCompany in
						Text((involvedCompany.company?.name)!)
					}
				}
			}
		}
	}
}

#Preview {
	ModelPreview { libraryGame in
		GameScreen(libraryGame: libraryGame)
			.environment(GameViewModel())
	}
}

