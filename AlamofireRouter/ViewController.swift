//
//  ViewController.swift
//  AlamofireRouter
//
//  Created by Jeff Schmitz on 2/12/17.
//  Copyright © 2017 Codefume. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

  func getFirstPost() {
    // Get first post
    let postEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
    
    Alamofire.request(postEndpoint, method: .get)
      .responseJSON { (response) in
        guard response.result.error == nil else {
          // got an error in getting the data, need to handle it
          print("error calling GET on /posts/1")
          print(response.result.error!)
          return
        }
        
        if let value: Any = response.result.value {
          // handle the results as JSON, without a bunch of nested if loops
          let post = JSON(value)
          // now we have the results, let's just print them though a tableview would definitely be better UI:
          print("The post is: " + post.description)
          if let title = post["title"].string {
            // to access a field:
            print("The title is: " + title)
          } else {
            print("error parsing /posts/1")
          }
        }
    }
  }
  
  func createPost() {
    let postsEndpoint: String = "http://jsonplaceholder.typicode.com/posts"
    let newPost = ["title": "Frist Psot", "body": "I iz fisrt", "userId": 1] as [String : Any]
    
    Alamofire.request(postsEndpoint, method: .post, parameters: newPost)
      .responseJSON { (response) in
        guard response.result.error == nil else {
          // got an error in getting the data, need to handle it
          print("error calling GET on /posts/1")
          print(response.result.error!)
          return
        }

        if let value: Any = response.result.value {
          // handle the results as JSON, without a bunch of nested if loops
          let post = JSON(value)
          print("The post is: " + post.description)
        }
    }
  }
  
  func deleteFirstPost() {
    let firstPostEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
    Alamofire.request(firstPostEndpoint, method: .delete)
      .responseJSON { response in
        if response.result.isSuccess {
          print("Delete succeeded on /posts/1")
        }
        if let error = response.result.error {
          // got an error while deleting, need to handle it
          print("error calling DELETE on /posts/1")
          print(error)
        }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    getFirstPost()
    
    createPost()

    deleteFirstPost()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

