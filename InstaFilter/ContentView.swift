//
//  ContentView.swift
//  InstaFilter
//
//  Created by Chris Wu on 6/5/20.
//  Copyright © 2020 Chris Wu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var image : Image?
    //@State private var backgroundColor = Color.white
    
    var body: some View {
        VStack {
            image?
            .resizable()
            .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        image = Image("ookla")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
