//
//  ContentView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 31/05/2024.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
	
	@Environment(\.modelContext) private var modelContext
	@Environment(GameViewModel.self) var viewModel
	
	@Query private var games: [Game]
	
	@State private var showingSheet = false
	
	var body: some View {
		NavigationStack {
			
			VStack {
				if !games.isEmpty {
					List {
						ForEach(games) { game in
							NavigationLink(value: game) {
								Text(game.name)
							}
								.swipeActions {
									Button(role: .destructive) {
										modelContext.delete(game)
									} label: {
										Label("Delete", systemImage: "trash")
									}
								}
						}
					}
					.navigationDestination(for: Game.self) { game in
						GameScreen(game: game)
					}
				} else {
					Text("This will be the list of games")
				}
			}
			.sheet(isPresented: $showingSheet) {
				NavigationStack {
					SearchScreen()
						.toolbar {
							Button(action: {
								showingSheet.toggle()
							}, label: {
								Image(systemName: "xmark")
							})
						}
				}
			}
			.navigationTitle("My Games")
			.toolbar {
				Button(action: {
					showingSheet.toggle()
				}, label: {
					Image(systemName: "magnifyingglass")
				})
			}
		}
	}
}


#Preview {
	HomeScreen()
		.modelContainer(previewContainer)
		.environment(GameViewModel())
}
