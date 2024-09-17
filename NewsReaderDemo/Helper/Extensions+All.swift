//
//  Extensions+All.swift
//  NewsReaderDemo
//
//  Created by IA on 16/09/24.
//

import UIKit
//
// MARK: - extension UIViewController
//
extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: StringConstants.ok, style: .default)
        alertController.addAction(ok)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}

//
// MARK: - UIActivityIndicatorView
//
extension UIActivityIndicatorView {
    func startAnimating(in view: UIView) {
        if self.superview == nil {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.hidesWhenStopped = true
            view.addSubview(self)
            NSLayoutConstraint.activate([
                self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
        self.startAnimating()
    }
    
    func stopAnimatingIndicator() {
        self.stopAnimating()
        self.removeFromSuperview()
    }
}

//
// MARK: - extension URLRequest
//
extension URLRequest {
    func debug() {
        print("\(self.httpMethod!) \(self.url!)")
        print("Headers:")
        print(self.allHTTPHeaderFields!)
        print("Body:")
        print(String(data: self.httpBody ?? Data(), encoding: .utf8)!)
        print("\n")
    }
}

//
// MARK: - extension String
//
extension String {
    func width(withFont font: UIFont, maxHeight: CGFloat) -> CGFloat {
        let textAttributes = [NSAttributedString.Key.font: font]
        let textSize = (self as NSString).boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: maxHeight),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: textAttributes,
            context: nil
        ).size
        return textSize.width + Spacing.viewMarginSmall
    }
    
    func toCustomDateString() -> String? {
        // Step 1: Parse the ISO 8601 date string into a Date object
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        isoFormatter.timeZone = TimeZone(abbreviation: "UTC") // Ensure it parses in UTC
        
        guard let date = isoFormatter.date(from: self) else {
            return nil
        }
        
        // Step 2: Format the Date object into the custom date string format
        let customFormatter = DateFormatter()
        customFormatter.dateFormat = "EEE dd MMM h:mm a" // Desired format
        customFormatter.timeZone = TimeZone.current // Use the local time zone for display
        
        return customFormatter.string(from: date)
    }
}
