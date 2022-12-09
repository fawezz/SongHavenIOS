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
        Button(action: action ) {
            Image(systemName: "arrow.left").foregroundColor(.white)
                .frame(width: 20, height: 20)
                .padding(8).background(Color.main_color)
                .cornerRadius(20)
                .shadow(color: Color.black,radius: 8, x: 0, y: 5)
        }
    }
    
}
//        Button(action: action){
//            Image(systemName: "arrowshape.turn.up.backward")
//                .aspectRatio(contentMode: .fit)
//                .foregroundColor(.main_color)
//        }
//    }
