//
//  ImageCacheManager.swift
//  NewsReaderDemo
//
//  Created by IA on 17/09/24.
//

import UIKit

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    
    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    
    private lazy var cacheDirectory: URL = {
        let directory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        return directory.appendingPathComponent("ImageCache")
    }()
    
    private init() {
        // Create the cache directory if it doesn't exist
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    func image(for url: URL) -> UIImage? {
        let key = url.absoluteString as NSString
        
        // Check memory cache
        if let image = memoryCache.object(forKey: key) {
            return image
        }
        
        // Check disk cache
        let fileURL = cacheDirectory.appendingPathComponent(key.lastPathComponent)
        if let imageData = try? Data(contentsOf: fileURL),
           let image = UIImage(data: imageData) {
            // Store in memory cache for future use
            memoryCache.setObject(image, forKey: key)
            return image
        }
        
        return nil
    }
    
    func store(image: UIImage, for url: URL) {
        let key = url.absoluteString as NSString
        
        // Store in memory cache
        memoryCache.setObject(image, forKey: key)
        
        // Store in disk cache
        let fileURL = cacheDirectory.appendingPathComponent(key.lastPathComponent)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: fileURL)
        }
    }
}

extension UIImageView {
    
    func loadImage(from url: URL, placeholder: UIImage? = UIImage(named: ImageConstants.imagePlaceholder)) {
        // Set placeholder image
        self.image = placeholder
        
        // Check if image is already cached
        if let cachedImage = ImageCacheManager.shared.image(for: url) {
            self.image = cachedImage
            return
        }
        
        // Download image
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Image download error: \(error.localizedDescription)")
                // Set placeholder image in case of error
                DispatchQueue.main.async {
                    self.image = placeholder
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                // Set placeholder image if image data is invalid
                DispatchQueue.main.async {
                    self.image = placeholder
                }
                return
            }
            
            // Cache the image
            ImageCacheManager.shared.store(image: image, for: url)
            
            // Update the imageView on the main thread
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }
}
