import Foundation
import CWebP
import CoreGraphics

public func decodeWebPImage(from data: Data) -> CGImage? {
    var rawWidth: Int32 = 0
    var rawHeight: Int32 = 0
    
    let rawData = data.withUnsafeBytes { pointer in
        WebPDecodeRGBA(
            pointer.bindMemory(to: UInt8.self).baseAddress,
            data.count,
            &rawWidth,
            &rawHeight
        )
    }
    
    guard let rawData else {
        return nil
    }
    
    defer {
        WebPFree(rawData)
    }
    
    let width = Int(rawWidth)
    let height = Int(rawHeight)
    let bitsPerComponent = 8
    let componentsPerPixel = 4
    let bitsPerPixel = bitsPerComponent * componentsPerPixel
    let bytesPerRow = componentsPerPixel * width
    let size = width * bytesPerRow
    
    let space = CGColorSpace(name: CGColorSpace.sRGB)
    
    guard let space else {
        return nil
    }
    
    let bitmapInfo = CGBitmapInfo(alpha: .premultipliedLast)
    
    let provider = CGDataProvider(
        dataInfo: nil,
        data: rawData,
        size: size) { _, _, _ in }
    
    guard let provider else {
        return nil
    }
    
    return .init(
        width: width,
        height: height,
        bitsPerComponent: bitsPerComponent,
        bitsPerPixel: bitsPerPixel,
        bytesPerRow: bytesPerRow,
        space: space,
        bitmapInfo: bitmapInfo,
        provider: provider,
        decode: nil,
        shouldInterpolate: true,
        intent: .defaultIntent
    )
}
