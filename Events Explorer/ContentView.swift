//
//  ContentView.swift
//  Events Explorer
//
//  Created by Ethan Ratnofsky on 5/1/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel() // View manager
    
    var body: some View {
        VStack {
            // Static title
            Text("Events Explorer")
                .font(.largeTitle)
                .padding(.top, 10)
                .padding(.bottom, 30)
            
            // In-app browser view
            ZStack {
                WebView(url: viewModel.url, viewModel: viewModel)
                    .padding(.horizontal, 30)
                
                // Load gray frame on top if web view is loading
                if (viewModel.isLoading) {
                    Color(red: 217/255, green: 217/255, blue: 217/255)
                        .padding(.horizontal, 30)
                }
            }

            // Status text
            Text(viewModel.statusText)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
                .padding(.bottom, 10)
                .onTapGesture {
                    viewModel.navigateToEvent()
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
