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
	
	@State private var showingSheet = false
	
	var body: some View {
		NavigationStack {
			
			VStack {
				List{
					Section(header: Text("My Library")) {
						NavigationLink(value: "All games") {
							Text("All Games")
						}
					}
					Section(header: Text("Game Status")) {
						ForEach(Status.allCases, id: \.id) { status in
							NavigationLink(value: status) {
								Text("\(status.name)")
							}
						}
					}
				}
				.navigationDestination(for: String.self) { title in
					CategoryScreen(status: nil, screenTitle: title)
				}
				.navigationDestination(for: Status.self) { status in
					CategoryScreen(status: status, screenTitle: status.name)
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
			.navigationTitle("GameShelf")
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
