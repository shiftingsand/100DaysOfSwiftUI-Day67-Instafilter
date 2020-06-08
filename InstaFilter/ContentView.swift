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
    @State private var filterIntensity = 0.5
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                
                if nil != image {
                    image?
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .onTapGesture() {
                // select image
            }
            
            HStack {
                Text("Intensity")
                Slider(value: self.$filterIntensity)
            }.padding(.vertical)
            
            HStack {
                Button("Change filter") {
                    //self.showImagePicker = true
                }
                
                Spacer()
                
                Button("Save") {
                    
                }
            }
        }
        .padding([.horizontal, .bottom])
        .navigationBarTitle("Instafilter")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
