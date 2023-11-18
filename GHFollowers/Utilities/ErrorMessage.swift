//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Vince Muller on 9/7/23.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request, please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}
