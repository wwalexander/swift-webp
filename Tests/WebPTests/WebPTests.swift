import Foundation
import Testing
@testable import WebP
import CoreGraphics
import ImageIO
import UniformTypeIdentifiers

@Test func example() async throws {
    let url = try #require(#bundle.url(forResource: "Nærøyfjorden, Norway - from Breiskrednosi. UNESCO World Heritage", withExtension: "webp"))
    let data = try Data(contentsOf: url)
    let image = try #require(decodeWebPImage(from: data))
    let destinationURL = URL.temporaryDirectory.appending(component: url.deletingPathExtension().appendingPathExtension(for: .png).lastPathComponent)
    
    let destination = try #require(CGImageDestinationCreateWithURL(
        destinationURL as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
    ))
    
    CGImageDestinationAddImage(destination, image, nil)
    CGImageDestinationFinalize(destination)
    try FileManager.default.removeItem(at: destinationURL)
}

