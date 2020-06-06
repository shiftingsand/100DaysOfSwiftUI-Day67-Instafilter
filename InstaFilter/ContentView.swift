//
//  ContentView.swift
//  InstaFilter
//
//  Created by Chris Wu on 6/5/20.
//  Copyright © 2020 Chris Wu. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image : Image?
    @State private var showImagePicker = false
    
    var body: some View {
        VStack {
            Button("Press me") {
                self.showImagePicker = true
            }
            image?
                .resizable()
                .scaledToFit()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
