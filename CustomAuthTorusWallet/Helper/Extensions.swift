//
//  Extensions.swift
//  OpenLoginKeyViewer
//
//  Created by Dhruv Jaiswal on 24/03/22.
//

import SwiftUI
import UIKit

extension Network: CaseIterable {
    public static var allCases: [Network] {
        return [.testnet]
    }
}

protocol MenuPickerProtocol: Hashable {
    var name: String { get }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
// extension UIColor {
//    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
//        var red: CGFloat = 0
//        var green: CGFloat = 0
//        var blue: CGFloat = 0
//        var alpha: CGFloat = 0
//        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//
//        return (red, green, blue, alpha)
//    }
// }
//
// extension Color {
//    
//    init(uiColor: UIColor) {
//        self.init(red: Double(uiColor.rgba.red),
//                  green: Double(uiColor.rgba.green),
//                  blue: Double(uiColor.rgba.blue),
//                  opacity: Double(uiColor.rgba.alpha))
//    }
// }

extension Network: MenuPickerProtocol {
    var networkURL: String {
        switch self {
        case .testnet:
            return "testnet"
        }
    }

    var name: String {
        switch self {
        case .testnet:
            return "Testnet"
        }
    }
}

enum OpenLoginError: Error {
    case accountError
}

extension Color {

}

extension Color {
    static func bkgColor() -> Color {
        return Color("background")
    }

    static func labelColor() -> Color {
        return Color("LabelColor")
    }

    static func themeColor() -> Color {
        return Color("themeColor")
    }

    static func grayColor() -> Color {
        return Color("grayColor")
    }

    static func systemBlackWhiteColor() -> Color {
        return Color("systemWhiteBlack")
    }

    static func dropDownBkgColor() -> Color {
        return Color("dropDownBkgColor")
    }

    static func borderColor() -> Color {
        return Color("borderColor")
    }
    static func blockchainIndicatorBkgColor() -> Color {
        return Color("blockchainIndicatorBkgColor")
    }

    static func whiteGrayColor() -> Color {
        return Color("whiteGrayColor")
    }
    static func tabBarColor() -> Color {
        return Color("tabBarColor")
    }
    static func blueWhiteColor() -> Color {
        return Color("blueWhiteColor")
    }
}

extension String {
    func invalidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return !emailPred.evaluate(with: self)
    }
}

extension CustomAuthProvider {
    var img: String {
        switch self {
        case .GOOGLE:
            return "Google"
        case .FACEBOOK:
            return "Facebook"
        case .REDDIT:
            return ("Reddit")
        case .DISCORD:
            return ("Discord")
        case .TWITCH:
            return ("Twitch")
        case .APPLE:
            return ("Apple")
        case .GITHUB:
            return ("Github")
        case .WEIBO:
            return ("Kakao")
        case .LINKEDIN:
            return ("Linkedin")
        case .TWITTER:
            return ("Twitter")
        case .EMAIL_PASSWORDLESS:
            return ("")
        case .KAKAO:
            return "Kakao"
        case .WECHAT:
            return "Wechat"
        }
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

import Foundation
import web3
class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0

    var center: NotificationCenter
    init(center: NotificationCenter = .default) {
        self.center = center
        // 4. Tell the notification center to listen to the system keyboardWillShow and keyboardWillHide notification
        center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            withAnimation {
                currentHeight = keyboardSize.height
            }
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        withAnimation {
            currentHeight = 0
        }
    }
}

extension Int {
    func toBool() -> Bool {
        self != 0
    }
}
