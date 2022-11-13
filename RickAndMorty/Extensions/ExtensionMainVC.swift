import UIKit

extension MainViewController {
    
    //MARK: Setting a monochrome filter on the image if the hero is dead

    func monochromaticImage(from image: UIImage, in color: UIColor) -> UIImage {
        
        guard let img = CIImage(image: image) else { return image }
        
        let color = CIColor(color: color)
        guard let outputImage = CIFilter(name: "CIColorMonochrome",
                                         parameters: ["inputImage" : img,
                                                      "inputColor" : color])?.outputImage  else {
            return image
        }
        
        let context = CIContext()
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let newImage = UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
            return newImage
        }
        return image
    }
}

