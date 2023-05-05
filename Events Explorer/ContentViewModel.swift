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
    @Published var isLoading: Bool = true
    @Published var statusText: String = "Loading..."
    @Published var eventUrl: String?

    // URL to load in web view
    var url: String = "https://www.sfstation.com/calendar"
    
    // Scrapes the name of and link to the first event displayed on a webpage loaded in a WKWebView
    func scrapeFirstEvent(webView: WKWebView) {
        // Scrape event name
        let queryEventName = "document.querySelector('.event-wrapper .ev_in span[itemprop=name]').innerText"
        webView.evaluateJavaScript(queryEventName) { (result, error) in
            // Attempt to cast result as a string and assign it to `eventName` variable
            guard let eventName = result as? String, error == nil else {
                // If there is an error in casting the result as a string or
                // if error is not nil, simply return
                return
            }
            
            // Update the status text that is shown on the view
            self.statusText = eventName
        }
        
        // Scrape event URL
        let queryEventUrl = "document.querySelector('.event-wrapper .ev_in a').getAttribute('href')"
        webView.evaluateJavaScript(queryEventUrl) { (result, error) in
            // Attempt to cast result as a string and assign it to `eventUrl` variable
            guard let eventUrl = result as? String, error == nil else {
                // If there is an error in casting the result as a string or
                // if error is not nil, simply return
                return
            }
            
            // Update the status text that is shown on the view
            self.eventUrl = eventUrl
        }
    }
    
    // Navigates to an event's webpage in a WKWebView
    func navigateToEvent(webView: WKWebView) {
        if (self.eventUrl != nil) {
            let url = URL(string: self.eventUrl!)!
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
