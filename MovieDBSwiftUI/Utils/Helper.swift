//
//  Helper.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 21/07/23.
//

import Foundation
import UIKit
import SwiftUI

//MARK: - String extension
extension String {
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

//MARK: - DateFormatter extension
extension DateFormatter {
    static var longDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    static var stringToDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }
    
    static func convertDateString(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM, yyyy"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return "" // Return nil in case the input string is not a valid date in the specified format
        }
    }
    
    static func convertMinutesToHoursAndMinutes(_ duration: Int) -> String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        let seconds = duration % 60
        
        var formattedDuration = ""
        
        if hours > 0 {
            formattedDuration += "\(hours)h "
        }
        
        if minutes > 0 {
            formattedDuration += "\(minutes)m "
        }
        
        formattedDuration += "\(seconds)s"
        
        return formattedDuration
    }
}

//MARK: - UIImage extension
extension UIImage {
    func aspectFittedToHeight(imageSize : CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: imageSize))
        }
    }
    
    func compressedImage(imageSize : CGSize) -> UIImage {
        let resizedImage = self.aspectFittedToHeight(imageSize: imageSize)
        resizedImage.jpegData(compressionQuality: 0.2)
        return resizedImage
    }
    
    func compressImageAndConvertToBase64(imageSize : CGSize) -> String? {
        let resizedImage = self.aspectFittedToHeight(imageSize: imageSize)
        if let imageData = resizedImage.jpegData(compressionQuality: 0.2) {
            let base64String = imageData.base64EncodedString(options: [])
            return base64String
        }
        return nil
    }
}

//MARK: - View Extension for UI Building
extension View {
    func closeAllKeyboards() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func disbableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    func hAlign(_ align: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: align)
    }
    
    func vAlign(_ align: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: align)
    }
    
    func border(_ width: CGFloat, _ color: Color) -> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
    
    func fillView(_ color: Color) -> some View {
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color)
            }
    }
    
    func navigationBarColor(backgroundColor: UIColor, tintColor: UIColor) -> some View {
        self.modifier(NavigationBarColorModifier(backgroundColor: backgroundColor, tintColor: tintColor))
    }
}

//MARK: - NavigationBar color modifier for custom color
struct NavigationBarColorModifier: ViewModifier {
    var backgroundColor: UIColor
    var tintColor: UIColor
    
    init(backgroundColor: UIColor, tintColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: tintColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = tintColor
    }
    
    func body(content: Content) -> some View {
        content
    }
}
