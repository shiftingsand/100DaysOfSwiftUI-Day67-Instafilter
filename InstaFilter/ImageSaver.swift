//
//  ImageSaver.swift
//  InstaFilter
//
//  Created by Chris Wu on 6/9/20.
//  Copyright © 2020 Chris Wu. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    var successHandler : (() -> Void)?
    var errorHandler : ((Error) -> Void)?

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        // save complete
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
