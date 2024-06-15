//
//  GameView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 14/06/2024.
//

import SwiftUI
import SwiftData

struct GameDetailsView: View {
	
	@Environment(\.modelContext) private var modelContext
	@Environment(GameViewModel.self) var viewModel
	@Environment(\.isPresented) var isPresented
	
	@Query private var games: [Game]
	
	@State private var status = Status.onShelf
	@State private var statusChanged = false
	@State private var newStatusId = 0
	
	init(game: Game) {
		
		let id = game.id
		let predicate = #Predicate<Game> { game in
			game.id == id
		}
		
		_games = Query(filter: predicate, sort: \Game.name )
	}
	
	var body: some View {
		
		let selectedGame = viewModel.selectedGame
		
		if let game = selectedGame {
			
			VStack(spacing: 20) {
				if games.isEmpty {
					AddToLibraryButtonView(game: game)
				}
				
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
				
				Picker("Status", selection: $status) {
					ForEach(Status.allCases) { status in
						Text(status.name).tag(status)
					}
				}
				.onChange(of: status, { oldValue, newValue in
					print("on ChangeStatus: \(newValue)")
					statusChanged = true
					newStatusId = newValue.id
				})
				
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
			}
			.onAppear {
				print("GameDetailsView onAppear: \(game.statusId)")
				print("GameDetailsView onAppear: \(game.status)")
				status = game.status
			}
			.onChange(of: isPresented) { oldValue, newValue in
				if !newValue && statusChanged {
					game.statusId = newStatusId
					modelContext.insert(game)
				}
			}
		}
	}
}

//#Preview {
//    GameView()
//}
