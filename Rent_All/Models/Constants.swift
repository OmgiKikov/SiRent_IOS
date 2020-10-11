//
//  Constants.swift
//  Rent_All
//
//  Created by RADICAL START on 18/03/19.
//  Copyright © 2019 RADICAL START. All rights reserved.
//

import Foundation
import UIKit
import Apollo

//****************************************************** Defines Fonts & AppColors ***************************************************************>

let FULLWIDTH  = UIScreen.main.bounds.width

let FULLHEIGHT = UIScreen.main.bounds.height

//MARK: - Default language

let DEFAULT_LANGUAGE = "English"
//BASE URL

enum Environment: String {
    case development = "dev"
    case production = "production"
    case localhost = "localhost"
}

let environment = Environment.production
var BASE_URL : String {
    get {
        switch environment {
        case .development:
            return "https://heku.world"
        case .production:
            return "https://heku.world"
        case .localhost:
            return "https://heku.world"
        }
    }
}

let IMAGE_AVATAR_MEDIUM = "\(BASE_URL)/images/avatar/medium_"
let IMAGE_AVATAR_SMALL = "\(BASE_URL)/images/avatar/small_"
let IMAGE_AVATAR_URL = "\(BASE_URL)/images/avatar/"
let IMAGE_LISTING_MEDIUM = "\(BASE_URL)/images/upload/x_medium_"
let IMAGE_LISTING_SMALL = "\(BASE_URL)/images/upload/x_small_"
let POPULAR_LOCATION_IMAGE = "\(BASE_URL)/images/popularLocation/"
let IMAGE_UPLOAD_PHOTO = "\(BASE_URL)/uploadPhoto"
let LISTINGIMAGE_UPLOAD = "\(BASE_URL)/uploadListPhoto"
let SHARE_URL = "\(BASE_URL)/rooms/"
let ABOUT_URL = "\(BASE_URL)/about"
let TERMS_URL = "\(BASE_URL)/privacy"
let HELP_URL = "\(BASE_URL)/contact"
let GUEST = "guest"
let HOST = "host"

//MARK: Device Models
let IS_IPHONE_XR = UIDevice().userInterfaceIdiom == .phone && (UIScreen.main.nativeBounds.height == 1792 || UIScreen.main.nativeBounds.height == 2688)
let IS_IPHONE_X = UIDevice().userInterfaceIdiom == .phone && (UIScreen.main.nativeBounds.height == 2436)
let IS_IPHONE_PLUS = UIDevice().userInterfaceIdiom == .phone && (UIScreen.main.nativeBounds.height == 2208 || UIScreen.main.nativeBounds.height == 1920)
let IS_IPHONE_678 = UIDevice().userInterfaceIdiom == .phone && (UIScreen.main.nativeBounds.height == 1334)
let IS_IPHONE_5 = UIDevice().userInterfaceIdiom == .phone && (UIScreen.main.nativeBounds.height == 1136)
let IS_IPHONE_XS_MAX = UIDevice().userInterfaceIdiom == .phone && (UIScreen.main.nativeBounds.height == 2688)

let categoryIdentifier = "myNotificationCategory"

let PRIMARY_COLOR = [UIColor().hexValue(hex:"007E83"), UIColor().hexValue(hex: "005E72")]
let WHITE_COLOR = [UIColor().hexValue(hex:"ffffff").cgColor, UIColor().hexValue(hex: "ffffff").cgColor]
let TranspertantBlackColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.5)
let TabSelectedColor = UIColor(red: 255.0 / 255.0, green: 90.0 / 255.0, blue: 95.0 / 255.0, alpha: 1)
let grayTranspertantColor = UIColor(red: 211.0 / 255.0, green: 211.0 / 255.0, blue: 211.0 / 255.0, alpha: 0.5)
let grayTranspertant = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 0.3)
let TextDarkColor = UIColor(red: 66.0 / 255.0, green: 66.0 / 255.0, blue: 66.0 / 255.0, alpha:0.7)
let TextDarkColorOne = UIColor(red: 66.0 / 255.0, green: 66.0 / 255.0, blue: 66.0 / 255.0, alpha:1)
let TextLightColor = UIColor(red: 192.0 / 255.0, green: 192.0 / 255.0, blue: 192.0 / 255.0, alpha: 1)
let TextBorderColor = UIColor(red: 235.0 / 255.0, green: 235.0 / 255.0, blue: 235.0 / 255.0, alpha: 1)
let Red_color = UIColor(red: 255.0 / 255.0, green: 69.0 / 255.0, blue: 95.0 / 255.0, alpha: 1)
let photo_color = UIColor(red: 31.0 / 255.0, green: 33.0 / 255.0, blue: 36.0 / 255.0, alpha:0.5)
let SPECIAL_PRICING_COLOR = UIColor().hexValue(hex:"00B050")
let BOOKING_PRICING_COLOR = UIColor().hexValue(hex:"dee0de")
let grayColorCode = UIColor().hexValue(hex:"767676")


let GOOGLE_API_KEY = "AIzaSyAzSCNAX6UtdOiDuARA8r5RvQQGWmtEkkc"

var STRIPE_PUBLISHABLE_KEY : String{
    get{
        switch environment{
        case .development:
            return "pk_test_51HbAHpICJPA7MtUpZ5oCT5R8IvNVOfMPWuJWfPhxU3KBhKptDNmoOXkLMKr3BRhNK9G37V92g5xe1uqsJ81nN9Ep00nTvFIqzO"
        case .production:
            return "pk_test_51HbAHpICJPA7MtUpZ5oCT5R8IvNVOfMPWuJWfPhxU3KBhKptDNmoOXkLMKr3BRhNK9G37V92g5xe1uqsJ81nN9Ep00nTvFIqzO"
        case .localhost:
            return ""
        }
    }
}

var graphQLEndpoint : String {
    get {
        switch environment {
        case .development:
            return "https://heku.world/api/graphql/"
        case .production:
            return "http://159.89.13.89:4000/graphql"
        case .localhost:
            return "https://heku.world/api/graphql/"
        }
    }
}

let apollo = ApolloClient(url: URL(string:graphQLEndpoint)!)


func convertToDictionary(text: String) -> [[String: Any]]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}
