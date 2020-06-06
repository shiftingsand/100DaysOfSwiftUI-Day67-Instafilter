//
//  ImagePicker.swift
//  InstaFilter
//
//  Created by Chris Wu on 6/6/20.
//  Copyright © 2020 Chris Wu. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    //typealias UIViewControllerType = UIImagePickerController
}
