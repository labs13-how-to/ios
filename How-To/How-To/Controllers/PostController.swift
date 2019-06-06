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
        var idString = String(id)
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
    
    
    
    
}
