//
//  GameView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 05/06/2024.
//

import SwiftUI

struct GameView: View {
	
	@Environment(GameViewModel.self) var viewModel
	
	var game: LibraryGame
	
	var body: some View {
		ScrollView {
			VStack {
				Text(game.name)
				
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
				
				//				Text((game.cover?.imageId) ?? "N/A")
				
				if let rating = game.rating {
					Text("Rating: \(Int(rating))")
				}
				
				if let firstReleseDate = game.firstReleseDate {
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
				
				if let involvedCompanies = game.involvedCompanies {
					ForEach(involvedCompanies) {involvedCompany in
						Text((involvedCompany.company?.name)!)
					}
				}
			}
		}
	}
}

//#Preview {
//    GameView(libraryGame)
//}

