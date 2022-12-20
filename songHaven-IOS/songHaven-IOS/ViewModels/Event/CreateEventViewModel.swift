//
//  CreateEventViewModel.swift
//  songHaven-IOS
//
//  Created by SongH on 20/12/2022.
//

import Foundation
@MainActor class CreateEventViewModel: ObservableObject {
    @Published var titre = ""

    @Published public var dateEvent = Date ()
    @Published var description = ""
    @Published var isUploading: Bool = false
    @Published var isLoading: Bool = false
    @Published var navigator : String? = nil
}
