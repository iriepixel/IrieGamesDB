//
//  IrieGamesDBApp.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 31/05/2024.
//

import SwiftUI
import SwiftData

@main
struct IrieGamesDBApp: App {
	
	@State var model = GameViewModel()
	
    var body: some Scene {
        WindowGroup {
            HomeView()
				.environment(model)
//				.modelContainer(for: [GameLibraryItemModel.self])
        }
    }
}
