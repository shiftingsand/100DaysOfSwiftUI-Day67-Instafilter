//
//  ContentView.swift
//  InstaFilter
//
//  Created by Chris Wu on 6/5/20.
//  Copyright © 2020 Chris Wu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Let's change our background color!")
            .frame(width: 300, height: 300)
            .font(.largeTitle)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("My first action sheet"), message: Text("Pick a background color"), buttons: [
                .default(Text("blue")) {
                    self.backgroundColor = Color.blue
                },
                .default(Text("red")) {
                    self.backgroundColor = Color.red
                },
                .default(Text("orange")) {
                    self.backgroundColor = Color.orange
                },
                .default(Text("yellow")) {
                    self.backgroundColor = Color.yellow
                },
                .cancel()
            ])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
