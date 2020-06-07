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
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            Button("Press me") {
                self.showImagePicker = true
            }
            image?
                .resizable()
                .scaledToFit()
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
