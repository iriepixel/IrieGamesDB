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
	@Environment(GameViewModel.self) var gameViewModel
	
	@Query private var libraryGames: [LibraryGame]
	
	@State private var showingSheet = false
	
	var body: some View {
		NavigationStack {
			
			VStack {
				if !libraryGames.isEmpty {
					List {
						ForEach(libraryGames) { libraryGame in
							NavigationLink(value: libraryGame) {
								Text(libraryGame.name)
							}
								.swipeActions {
									Button {
										modelContext.delete(libraryGame)
									} label: {
										Label("Delete", systemImage: "trash")
									}
									.tint(.red)
								}
						}
					}
					.navigationDestination(for: LibraryGame.self) { libraryGame in
						GameScreen(gameId: libraryGame.id)
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
