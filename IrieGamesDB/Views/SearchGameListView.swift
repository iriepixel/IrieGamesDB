//
//  SearchGameListView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 14/06/2024.
//

import SwiftUI

struct SearchGameListView: View {
	
	@Environment(\.modelContext) private var modelContext
	@Environment(GameViewModel.self) var viewModel
	
    var body: some View {
		List{
			ForEach(viewModel.games) { game in
				NavigationLink(value: game) {
					HStack(spacing: 15) {
						if let imageId = game.cover?.imageId {
							let url = viewModel.coverURL(imageId: imageId)
							
							AsyncImage(url: url) { image in
								image
									.resizable()
									.aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
							} placeholder: {
								ProgressView()
							}
							.frame(width: 80, height: 107)
							.clipShape(RoundedRectangle(cornerRadius: 5))
						} else {
							GameCoverPlaceholderView()
						}
						
						VStack(alignment: .leading) {
							Text(game.name)
								.font(.subheadline)
								.bold()
						}
					}
				}
			}
		}
    }
}

#Preview {
    SearchGameListView()
}
