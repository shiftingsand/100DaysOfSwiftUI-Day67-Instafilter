//
//  ContentView.swift
//  InstaFilter
//
//  Created by Chris Wu on 6/5/20.
//  Copyright © 2020 Chris Wu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount : CGFloat = 0
    
    var body: some View {
        let blur = Binding<CGFloat> (
            get: {
                self.blurAmount
        },
            set: { nummy in
                self.blurAmount = nummy
                print("new blur=\(self.blurAmount)")
        }
        )
        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
            
            Slider(value: blur, in: 0...20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
