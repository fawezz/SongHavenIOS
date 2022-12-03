//
//  MyAppDelegate.swift
//  songHaven-IOS
//
//  Created by Apple Esprit on 3/12/2022.
//

import UIKit
import AVFAudio

class MyAppDelegate	: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
        } catch let error as NSError {
            print("Setting category to AVAudioSessionCategoryPlayback failed: \(error)")
        }
        // Other project setup
        return true
    }
}
