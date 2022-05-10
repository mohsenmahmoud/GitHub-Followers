//
//  GFError.swift
//  GHFollowers
//
//  Created by mohsen on 06/05/2022.
//

import Foundation
enum GFError : String , Error{
    
    case invalidUserName    = "this user created an invalid request. please try again."
    case unableToComplet    = "unable to complete your request. please check your internet conection."
    case invalidResponse    = "invalid rsponse from server. please try again."
    case invaliddata        = "the data received from the server was invalid  please try again."
    case unableToFavorite   = " there was an error favoriting this user. please try again"
    case alreadyInFavorite  = "you've already favorites this user. you must Really like them!"
    
    
}
