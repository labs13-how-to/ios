//
//  PostController.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/3/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

class PostController: Codable {
    
    let baseURL = URL(string: "https://lambda-how-to.herokuapp.com/")!
    
    var posts: [Post] = []
    var post: Post?
    var users: [User] = []
    var user: User?
    var favorites: [Favorite]?
    var favorite: Favorite?
    // MARK: TODO
    
    // create post
    // update post by id
    // delete post
    
    // get all posts
    func getPosts(completion: @escaping(Error?)-> Void = { _ in }) {
        let urlPlus = baseURL.appendingPathComponent("posts")
        
        print("\(urlPlus)")
        URLSession.shared.dataTask(with: urlPlus) { (data, _, error) in
            if let error = error {
                NSLog("Error retrieving posts: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No posts data returned from server")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let postsFromServer = try decoder.decode([Post].self, from: data)
//                let postsArray = Array(postsFromServer.values)
//                for post in postsFromServer {
//                    self.posts.append(post)
//                }
                self.posts = postsFromServer
                completion(nil)
            } catch {
                NSLog("Error decoding posts from server: \(error.localizedDescription)")
                return
            }
            
        }.resume()
    }
    // get specific post by id
   
    func getPostByID(id: Int, completion: @escaping(Error?)-> Void = { _ in }) {
        let idString = String(id)
        let urlPlus = baseURL.appendingPathComponent("posts").appendingPathComponent(idString)
        
        print("\(urlPlus)")
        URLSession.shared.dataTask(with: urlPlus) { (data, _, error) in
            if let error = error {
                NSLog("Error retrieving posts: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No posts data returned from server")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let singlePost = try decoder.decode([Post].self, from: data)
                self.post = singlePost[0]
                completion(nil)
            } catch {
                NSLog("Error decoding single post from server: \(error.localizedDescription)")
                return
            }
            
            }.resume()
    }
    
    func getUser(id: Int, completion: @escaping(Error?) -> Void = { _ in }) {
        let idString = String(id)
        let urlPlus = baseURL.appendingPathComponent("users").appendingPathComponent(idString)
        
        URLSession.shared.dataTask(with: urlPlus) { (data, _, error) in
            if let error = error {
                NSLog("Error retrieving user: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No user data returned from server")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let singleUser = try decoder.decode(User.self, from: data)
                self.user = singleUser
                completion(nil)
            } catch {
                NSLog("Error decoding single user from server: \(error.localizedDescription)")
                return
            }
            
            }.resume()
    }
    
    func getUserFavorites(id: Int, completion: @escaping(Error?) -> Void = { _ in}) {
        let idString = String(id)
        let urlPlus = baseURL.appendingPathComponent("favorites").appendingPathComponent("users").appendingPathComponent(idString)
        
        URLSession.shared.dataTask(with: urlPlus) { (data, _, error) in
            if let error = error {
                NSLog("Error retrieving user favorites: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No user favorites data returned from server")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                var favoriteArray: [Favorite] = []
                favoriteArray = try decoder.decode([Favorite].self, from: data)
                self.favorites = favoriteArray
                completion(nil)
            } catch {
                NSLog("Error decoding favoriteArray from server: \(error.localizedDescription)")
                return
            }
            
            }.resume()
    }
    
    func deletePost(id: Int, completion: @escaping((Error?) -> Void) = { _ in }) {
        let idString = String(id)
        let urlPlus = baseURL.appendingPathComponent("posts").appendingPathComponent(idString)
        
        var request = URLRequest(url: urlPlus)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error deleting post from server: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            completion(nil)
            }.resume()
    }
    
    func deleteUser(id: Int, completion: @escaping(Error?) -> Void = { _ in }) {
        let idString = String(id)
        let urlPlus = baseURL.appendingPathComponent("users").appendingPathComponent(idString)
        
        var request = URLRequest(url: urlPlus)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error deleting user from server: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            completion(nil)
            }.resume()
    } 
    
    func deleteFavorite(id: Int, completion: @escaping((Error?) -> Void) = { _ in }) {
        let idString = String(id)
        let urlPlus = baseURL.appendingPathComponent("favorites").appendingPathComponent(idString)
        
        var request = URLRequest(url: urlPlus)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error deleting favorite from server: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            completion(nil)
            }.resume()
    }
    
    
    
}
