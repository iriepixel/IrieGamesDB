//
//  GameView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 14/06/2024.
//

import SwiftUI

struct GameView: View {
	
	@Environment(\.modelContext) private var modelContext
	@Environment(GameViewModel.self) var viewModel
	
	var game: Game
	
	var body: some View {
		VStack(spacing: 20) {
			//				if let game = game {
			
			
			AddToLibraryButtonView(game: game)
			
			if let coverId = game.coverId ?? game.cover?.imageId{
				let url = viewModel.coverURL(imageId: coverId)
				
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
					Text(platform.abbreviation ?? "N/A")
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
}

//#Preview {
//    GameView()
//}
