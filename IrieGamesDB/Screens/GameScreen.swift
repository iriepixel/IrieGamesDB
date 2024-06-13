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
	
//	@State var selectedGameStatus = GameViewModel().selectedLibraryGame?.status

	
//	@State var selectedStatus = LibraryGame.Status.backlog
//	@State var selectedStatus: LibraryGame.Status
//	@State var selectedGame: LibraryGame?.Status
	
//	@State private var selectedStatus: Status = .electronics
	
//	var game: GameModel
//	var gameId: Int?
	
//	@State var selectedGameStatus: LibraryGame.Status?
	
	var body: some View {
		
		let game = viewModel.selectedLibraryGame
		
		ScrollView {
			if let game = game {
				VStack(spacing: 20) {
					
					Button(action: {
						modelContext.insert(game)
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
						.frame(width: 340, height: 460)
						.clipShape(RoundedRectangle(cornerRadius: 5))
					} else {
						GameCoverPlaceholderView()
					}
					
					Text(game.name)
						.font(.largeTitle)
						.bold()
					
					Picker("Status", selection: viewModel.) {
						ForEach(GameModel.Status.allCases, id: \.self) { status in
							Text(status.rawValue)
								.tag(status as GameModel.Status)
						}
					}
//					.onReceive([self.selectedGameStatus].publisher.first()) { status in
//						print(status)
//						game.status = status
//						do {
//							try modelContext.save()
//						} catch {
//							print("Error saving status: \(error)")
//						}
//					}
					
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
				}
				.navigationTitle(game.name)
				.navigationBarTitleDisplayMode(.inline)
			}
		}
		.padding(.horizontal)
		.onAppear {
//			if let gameId = gameId {
//				viewModel.fetchGameById(id: gameId)
//			}
		}
//		.onDisappear(perform: {
//			viewModel.selectedLibraryGame = nil
//		})
	}
}

//#Preview {
//	GameScreen(gameId: 203722)
	//	ModelPreview { libraryGame in
	//		GameScreen(libraryGame: libraryGame)
	//			.environment(GameViewModel())
	//	}
//}

