//
//  ContentView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 31/05/2024.
//

import SwiftUI

struct HomeView: View {
	
	@State private var showingSheet = false

	var body: some View {
		NavigationStack {
			Text("This will be the list of games")
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
