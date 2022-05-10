//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by mohsen on 20/04/2022.
//

import UIKit
class NetworkManager{
    
    static let shared = NetworkManager()
    
    let baceUrl = "https://api.github.com/users/"
    let cache   = NSCache<NSString , UIImage>()
    
   private init() {}
    
    func getFollower(for username : String , page : Int , complted : @escaping(Result<[Follower] , GFError>)->Void){
        let endpoint = baceUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        
        guard let url = URL(string: endpoint) else{
            complted(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                complted(.failure(.unableToComplet))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                complted(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                complted(.failure( .invaliddata))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let follower = try decoder.decode([Follower].self, from: data)
                complted(.success(follower))
            }catch{
                complted(.failure(.invaliddata))
            }
        }
        task.resume()
        
    }
    
    
    
    
    
    //user
    func getusers(for username : String , complted : @escaping(Result<User , GFError>)->Void){
        let endpoint = baceUrl + "\(username)"
        
        
        guard let url = URL(string: endpoint) else{
            complted(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                complted(.failure(.unableToComplet))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                complted(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                complted(.failure( .invaliddata))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let user = try decoder.decode(User.self, from: data)
                complted(.success(user))
            }catch{
                complted(.failure(.invaliddata))
            }
        }
        task.resume()
        
    }
}
