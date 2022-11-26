//
//  BackButton.swift
//  songHaven-IOS
//
//  Created by zewaff on 25/11/2022.
//

import SwiftUI

struct BackButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action){
            Image(systemName: "arrowshape.turn.up.backward")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.main_color)
        }
    }
}


