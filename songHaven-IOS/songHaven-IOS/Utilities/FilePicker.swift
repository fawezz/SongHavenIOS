//
//  FilePicker.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 31/12/2022.
//

import Foundation
import SwiftUI
import UIKit

struct FilePicker: UIViewControllerRepresentable {

    @Binding var isShowing: Bool
    @Binding var fileURL: URL?

    class Coordinator: NSObject, UIDocumentPickerDelegate {

        @Binding var isShowing: Bool
        @Binding var fileURL: URL?

        init(isShowing: Binding<Bool>, fileURL: Binding<URL?>) {
            _isShowing = isShowing
            _fileURL = fileURL
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            fileURL = urls.first
            isShowing = false
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            isShowing = false
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing, fileURL: $fileURL)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<FilePicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .import)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<FilePicker>) {

    }
}
