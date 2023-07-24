//
//  ContentView.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import SwiftUI

//Works as Splash screen or app entry point
struct ContentView: View {
    @State private var isLogoAnimated = false
    @State private var showMainView = false
    
    var body: some View {
        ZStack {
            Color.white // Set your desired background color for the splash screen
            if showMainView {
                MovieList()
            }
            //Showing Image view with animation, scale effect and transitions
            Image("logo")
                .scaleEffect(isLogoAnimated ? 1.5 : 1.0)
                .opacity(isLogoAnimated ? 0.0 : 1.0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        isLogoAnimated.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        showMainView = true
                    }
                }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
