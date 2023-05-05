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
    @Published var webView: WKWebView?
    @Published var isLoading: Bool = true
    @Published var statusText: String = "Loading..."

    // URL to load in web view
    var url: String = "https://www.sfstation.com/calendar"
    
    // Scrapes the name of the first event displayed on a webpage loaded in a WKWebView
    func scrapeFirstEventName() {
        // Scrape event name
        let queryEventName = "document.querySelector('.event-wrapper .ev_in span[itemprop=name]').innerText"
        webView?.evaluateJavaScript(queryEventName) { (result, error) in
            // Attempt to cast result as a string and assign it to `eventName` variable
            guard let eventName = result as? String, error == nil else {
                // If there is an error in casting the result as a string or
                // if error is not nil, simply return
                return
            }
            
            // Update the status text that is shown on the view
            self.statusText = eventName
        }
    }
    
    // Navigates to an event's webpage in a WKWebView
    func navigateToEvent() {
        // Scrape event link and click it
        let clickEvent = "document.querySelector('.event-wrapper .ev_in a').click()"
        webView?.evaluateJavaScript(clickEvent)
    }
}
