//
//  ContentView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 31/05/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
	
	@Environment(\.modelContext) private var modelContext
	@Environment(GameViewModel.self) var model
	
	@Query private var libraryGames: [LibraryGame]
	
	@State private var showingSheet = false
	
	var body: some View {
		NavigationStack {
			
			VStack {
				if !libraryGames.isEmpty {
					List {
						ForEach(libraryGames) { libraryGame in
							NavigationLink(libraryGame.name, value: libraryGame)
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
				} else {
					Text("This will be the list of games")
				}
			}
			.sheet(isPresented: $showingSheet) {
				NavigationStack {
					SearchView()
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
			.navigationDestination(for: LibraryGame.self) { libraryGame in
				GameView(game: libraryGame)
			}
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
	HomeView()
}
