//
//  ContentViewModel.swift
//  Events Explorer
//
//  Created by Ethan Ratnofsky on 5/3/23.
//

import Foundation
import WebKit

class ContentViewModel: NSObject, ObservableObject {
    // State
    @Published var isLoading = true
    @Published var statusText = "Loading..."

    // URL to load in web view
    var url = "https://www.sfstation.com/calendar"
}
