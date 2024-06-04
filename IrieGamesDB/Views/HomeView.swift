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
	
	@Query private var libraryGames: [LibraryGame]
	
	@State private var showingSheet = false

	var body: some View {
		NavigationStack {
			Text("This will be the list of games")
			
			List(libraryGames) { libraryGame in
				Text(libraryGame.name)
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
