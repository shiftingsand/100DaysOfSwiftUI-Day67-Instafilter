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

enum SliderTypes {
    case intensityOnly
    case radiusOnly
    case scaleOnly
    case intensityRadius
}

let edgesName = "Edges"
let gbName = "Gaussian Blur"
let pixellateName = "Pixellate"
let stName = "Sepia Tone"
let umName = "Unsharp Mask"
let vignetteName = "Vignette"

struct ContentView: View {
    let sliderDict : [ String : SliderTypes ] = [ edgesName : .intensityOnly, gbName : .radiusOnly, pixellateName : .scaleOnly, stName : .intensityOnly, umName : .intensityRadius, vignetteName : .intensityRadius ]
    @State private var image : Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var showingImagePicker = false
    @State private var currentFilter : CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var showSaveErrorAlert = false
    @State private var filterName = stName
    
    let context = CIContext()
    
    var returnSliderTypes : SliderTypes {
        if let mySlider = sliderDict[filterName] {
            return mySlider
        } else {
            return .intensityOnly
        }
    }
    
    var body: some View {
        let intensity = Binding<Double> (
            get: {
                self.filterIntensity
        },
            set: { nummy in
                self.filterIntensity = nummy
                self.applyProcessing()
        }
        )
        let radius = Binding<Double> (
            get: {
                self.filterRadius
        },
            set: { nummy in
                self.filterRadius = nummy
                self.applyProcessing()
        }
        )
        let scale = Binding<Double> (
            get: {
                self.filterScale
        },
            set: { nummy in
                self.filterScale = nummy
                self.applyProcessing()
        }
        )
        
        return NavigationView {
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
                    self.showingImagePicker = true
                }
                
                if returnSliderTypes == SliderTypes.intensityOnly ||
                    returnSliderTypes == SliderTypes.intensityRadius {
                    HStack {
                        Text("Intensity")
                        Slider(value: intensity)
                        
                    }.padding(.vertical)
                }
                
                if returnSliderTypes == SliderTypes.radiusOnly ||
                    returnSliderTypes == SliderTypes.intensityRadius {
                    HStack {
                        Text("Radius")
                        Slider(value: radius)
                        
                    }.padding(.vertical)
                }
                
                if returnSliderTypes == SliderTypes.scaleOnly {
                    HStack {
                        Text("Scale")
                        Slider(value: scale)
                        
                    }.padding(.vertical)
                }
                
                HStack {
                    Button("\(filterName)") {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            self.showSaveErrorAlert = true
                            return
                        }
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success!")
                        }
                        
                        imageSaver.errorHandler = { messy in
                            print("Ooops: \(messy.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                    .alert(isPresented: $showSaveErrorAlert) {
                        Alert(title: Text("Hold up!"), message: Text("You can't save because you haven't selected an image yet!"), dismissButton: .default(Text("OK")))
                    }
                }
            } // vstack
                .padding([.horizontal, .bottom])
                .navigationBarTitle("Instafilter")
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: self.$showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
//                    .default(Text("Crystallize")) {
//                        self.filterName = "Crystallize"
//                        self.setFilter(CIFilter.crystallize()) },
                    .default(Text(edgesName)) {
                        self.filterName = edgesName
                        self.setFilter(CIFilter.edges()) },
                    .default(Text(gbName)) {
                        self.filterName = gbName
                        self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text(pixellateName)) {
                        self.filterName = pixellateName
                        self.setFilter(CIFilter.pixellate()) },
                    .default(Text(stName)) {
                        self.filterName = stName
                        self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text(umName)) {
                        self.filterName = umName
                        self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text(vignetteName)) {
                        self.filterName = vignetteName
                        self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            }
        }
    }
    
    func applyProcessing() {
        //currentFilter.intensity = Float(filterIntensity)
        //currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func setFilter(_ filter : CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
