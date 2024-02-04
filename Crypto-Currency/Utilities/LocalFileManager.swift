//
//  LocalFileManager.swift
//  Crypto-Currency
//
//  Created by Omar on 04/02/2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    private init(){}
    
    func saveImage(image: UIImage, imageName: String, folderName: String){
        // create Folder
        createFolderIfNeede(folderName: folderName)
        // get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName,
                                                 folderName: folderName) else{
            return
        }
        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving Image \(imageName) "+error.localizedDescription)
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage?{
        guard let url = getURLForImage(imageName: imageName,
                                       folderName: folderName),
              FileManager.default.fileExists(atPath: url.path())
        else{
            return nil
        }
        return UIImage(contentsOfFile: url.path())
    }
    
    private func createFolderIfNeede(folderName: String){
        guard let url = getURLForFolder(folderName: folderName) else {return}
        
        if !FileManager.default.fileExists(atPath: url.path()){
            do {
                try FileManager.default.createDirectory(at: url,
                                                        withIntermediateDirectories: true)
            } catch let error {
                print("Error creating Directory \(folderName) "+error.localizedDescription)
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL?{
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
            return nil
        }
        return url
    }
    
    private func getURLForImage(imageName: String,folderName: String) -> URL?{
        guard let url = getURLForFolder(folderName: folderName) else{
            return nil
        }
        return url.appending(path: imageName ).appendingPathExtension(".png")
    }
}