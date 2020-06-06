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
    @State private var flipper = true
    
    var body: some View {
        VStack {
            Button("Press me") {
                self.flipper.toggle()
                self.loadImage()
            }
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "ookla") else {
            return
        }
        
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        var finalImage : CIFilter
        
        if flipper {
            let currentFilter = CIFilter.sepiaTone()
            currentFilter.inputImage = beginImage
            currentFilter.intensity = 1
            finalImage = currentFilter
        } else {
            // twirl hasn't been updated and you have to use old way
            guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
            currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
            finalImage = currentFilter
        }
        
        // returns CIImage
        guard let outputImage = finalImage.outputImage else {
            return
        }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiimage = UIImage(cgImage: cgimg)
            
            image = Image(uiImage: uiimage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
