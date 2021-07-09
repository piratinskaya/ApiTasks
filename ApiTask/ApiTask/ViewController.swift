//
//  ViewController.swift
//  ApiTask
//
//  Created by Юлия Пиратинская on 08.07.2021.
//

import UIKit

struct PostsF: Decodable {
    var id: Int
    var title: String?
    var userId: Int
    var body: String?
    
    init( id: Int, title: String?, userId: Int, body: String?){
       
        self.id = id
        self.title = title
        self.userId = userId
        self.body = body
    }
}

struct Comments: Decodable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}


//var postsF:  PostsF?
var posts = [PostsF]()

class ViewController: UIViewController {

    

    @IBOutlet var tableView: UITableView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.delegate = self
            tableView.dataSource = self
        }
    


    @IBAction func GetComment(_ sender: UIButton) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1/comments") else {return}

        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }

            guard let data = data else {return}

            do {
            let comment =  try JSONDecoder().decode([Comments].self, from: data)
                
                print(comment)

            }
            catch{
                print(error)
            }
        }.resume()

    
    
    }
    
    
    
    @IBAction func GetPost(_ sender: UIButton) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {return}

        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }

            guard let data = data else {return}

            do {
            let postsF =  try JSONDecoder().decode(PostsF.self, from: data)
                
                print(postsF)

            }
            catch{
                print(error)
            }
        }.resume()

    
    }
    //
    @IBAction func GetPhoto(_ sender: UIButton) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_start=0&_limit=3") else {return}

        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }

            guard let data = data else {return}

            do {
            let postsF =  try JSONDecoder().decode([PostsF].self, from: data)
                
                print(postsF)

            }
            catch{
                print(error)
            }
        }.resume()

    }
    
  
}

////////////////////////////
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapp")
    }
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titlecell", for: indexPath)
        cell.textLabel?.text = "posts"
        return cell
    }
}



