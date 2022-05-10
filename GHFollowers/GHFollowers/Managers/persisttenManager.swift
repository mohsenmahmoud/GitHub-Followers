//
//  persisttenManager.swift
//  GHFollowers
//
//  Created by mohsen on 08/05/2022.
//

import Foundation

enum persistenActionType{
    case add , remove
}


enum persisttenManager{
    static private let defaults = UserDefaults.standard
    
    enum keys{
        static let favorites = "favorites"
    }
    
    
    
    static func updateWith(favorite : Follower , actionType : persistenActionType, completed : @escaping (GFError?) -> Void){
        retrieveFavorites { result in
            switch result{
            case .success(let favorites):
               var retrieveFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrieveFavorites.contains(favorite) else {
                        completed(.alreadyInFavorite)
                        return
                    }
                    retrieveFavorites.append(favorite)
                    
                case .remove:
                    retrieveFavorites.removeAll {  $0.login == favorite.login}
                }
                
                completed(save(favorites: retrieveFavorites))
            case .failure(let error):
               completed(error)
            }
        }
        
    }
    
    
    static func retrieveFavorites(completed : @escaping (Result<[Follower] , GFError>) -> Void){
        guard let favoritesData = defaults.object(forKey: keys.favorites) as? Data else{
            completed(.success([]))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        }catch{
            completed(.failure(.unableToFavorite))
        }
        
    }
    
    
    
    static func save(favorites : [Follower]) -> GFError?{
        do{
            let encoder = JSONEncoder()
            let encodingFavorites = try encoder.encode(favorites)
            defaults.set(encodingFavorites, forKey: keys.favorites)
            return nil
        }catch{
            return .unableToFavorite
        }

    }
}
