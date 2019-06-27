//
//  UserController.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/9/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

class UserController: Codable {
    
    let baseURL = URL(string: "https://lambda-how-to.herokuapp.com/")!
    
    
    var allUsers: [User]?
    
    
//    static let shared = UserController()
    var currentUser: User?
    
    func getAllUsers(completion: @escaping(Error?) -> Void) {
        
        
        
        
    }
    
    func createUser(username: String, password: String, completion: @escaping(Error?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        /* Create session, and optionally set a URLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        /* Create the Request:
         Request (2) (POST https://lambda-how-to.herokuapp.com/users)
         */
        guard var URL = URL(string: "https://lambda-how-to.herokuapp.com/users") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        // Headers
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        // JSON Body
        let bodyObject: [String : Any] = [
            "username": username,
            "password": password
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
            
            guard let data = data else {
                NSLog("No user data returned from server")
                completion(NSError())
                return
            }
            
            do {
                print("This is the data:\(data)")
                let decoder = JSONDecoder()
                let result = try decoder.decode(UserResponse.self, from: data)
                
                self.currentUser = result.user[0]
                // Save User ID in UserDefaults so on relaunches we can fetch from saved ID number
                let defaults = UserDefaults.standard
                defaults.set(self.currentUser!.id, forKey: "ID")
                defaults.set(true, forKey: "ExistingUser")
    
                completion(nil)
            } catch {
                NSLog("Error decoding newly created user from server: \(error.localizedDescription)")
                return
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func updateUser(id: Int, username: String, auth_id: String, role: String, created_at: String, completion: @escaping(Error?) -> Void) {
        let user = User(id: id, auth_id: auth_id, username: username, role: role, created_at: created_at)
        currentUser = user
        print("\(user.username)")
        let idString = String(id)
        let urlPlus = baseURL.appendingPathComponent("users").appendingPathComponent(idString)
        
        let sessionConfig = URLSessionConfiguration.default
        
        /* Create session, and optionally set a URLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        /* Create the Request:
         Request (2) (PUT urlPlus)
         */
        guard var URL = URL(string: "https://lambda-how-to.herokuapp.com/users/1") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "PUT"
        
        // Headers
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        // JSON Body
        
        let bodyObject: [String : Any] = [
            "username": username,
            "id": id,
            "auth_id": auth_id,
            "role": role,
            "created_at": created_at
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }


    func logOut() {
        currentUser = nil
    }
    
    
    func fetchUser(id: String, completion: @escaping(Error?)-> Void = { _ in }) {
//        let idString = String(id)
        let urlPlus = baseURL.appendingPathComponent("users").appendingPathComponent(id)
        print(urlPlus)
        
        URLSession.shared.dataTask(with: urlPlus) { (data, response, error ) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 404 {
                    completion(error)
                    return
                }
            }
            
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
                print("\(data)")
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)
                self.currentUser = user
                completion(nil)
            } catch {
                NSLog("Error decoding single user from server: \(error.localizedDescription)")
                return
            }
        }.resume()
        
    }
}
