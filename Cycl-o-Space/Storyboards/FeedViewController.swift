//
//  FeedViewController.swift
//  Cycl-o-Space
//
//  Created by Kervens Delpe on 11/19/21.
//

import UIKit
import Parse
import AlamofireImage
import Gemini

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var posts = [PFObject]()
    
    var currentUser = PFUser.current()
    
    var numberofPosts = Int()
    let myRefreshControl = UIRefreshControl()
    
    
    @IBOutlet weak var collectionView: GeminiCollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPosts()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        collectionView.gemini
//            .pitchRotationAnimation()
//            .degree(45)
//            .pitchEffect(.pitchUp)
        collectionView.gemini
            .yawRotationAnimation()
            .degree(45)
            .yawEffect(.yawUp)


    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        myRefreshControl.addTarget(self, action: #selector(loadMorePosts), for: .valueChanged)
        self.collectionView.refreshControl = myRefreshControl
        
        collectionView.reloadData()

    }
    @objc func loadPosts(){
        numberofPosts = 20
        let post = PFObject(className: "Posts")
        
        //post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        let postQuery = PFQuery(className:"Posts")
        if let user = PFUser.current() {
          postQuery.whereKey("author", equalTo: user)
        }
//        let query = PFQuery(className:"Posts")
//        query.includeKeys(["author", "comments", "comments.author"])

        postQuery.limit = numberofPosts
        
        postQuery.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts.removeAll()
                self.posts = posts!
                self.posts.reverse()
                self.collectionView.reloadData()
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @objc func loadMorePosts(){
        numberofPosts += 20
        let post = PFObject(className: "Posts")
        
        //post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        let postQuery = PFQuery(className:"Posts")
        if let user = PFUser.current() {
          postQuery.whereKey("author", equalTo: user)
        }
//        postQuery.includeKeys(["author", "comments", "comments.author"])
        postQuery.limit = numberofPosts
        
        postQuery.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts.removeAll()
                self.posts = posts!
                self.posts.reverse()
                self.collectionView.reloadData()
                self.myRefreshControl.endRefreshing()
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let post = posts[indexPath.row]
        print(post)
        

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postGridCell", for: indexPath) as! postGridCell
        self.collectionView.animateCell(cell)
                
        
       // let user = post["author"] as! PFUser

        cell.usernameLabel.text = (PFUser.current()?.username)! + "!";
        
       //cell.captionLabel.text = post["caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        
        let urlString = imageFile.url!
        
        let url = URL(string: urlString)!
        
        cell.postImage.af_setImage(withURL: url)
        
       
       cell.postImage?.layer.cornerRadius = (cell.postImage?.frame.width)! / 6
    
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.collectionView.animateVisibleCells()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? postGridCell {
            
            self.collectionView.animateCell(cell)
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 //   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        
        // Pass the selected object to the new view controller.
 //   }


}
