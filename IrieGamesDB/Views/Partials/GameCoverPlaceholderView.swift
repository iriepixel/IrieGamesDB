//
//  GameCoverPlaceholderView.swift
//  IrieGamesDB
//
//  Created by Jev Smolnikov on 03/06/2024.
//

import SwiftUI

struct GameCoverPlaceholderView: View {
	
    var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 5)
				.foregroundColor(.gray)
				.opacity(0.2)
				.frame(width: 80, height: 107)
			Image(systemName: "gamecontroller")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 40, height: 40)
				.opacity(0.5)
		}
    }
}

#Preview {
    GameCoverPlaceholderView()
}
