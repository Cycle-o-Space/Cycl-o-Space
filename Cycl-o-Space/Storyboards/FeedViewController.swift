//
//  FeedViewController.swift
//  Cycl-o-Space
//
//  Created by Kervens Delpe on 11/19/21.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var posts = [PFObject]()
    
    var currentUser = PFUser.current()
    
    var numberofPosts = Int()
    let myRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPosts()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        layout.minimumLineSpacing = 55

        layout.minimumInteritemSpacing = 10

        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 2
        

        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//self.loadMorePosts()

        myRefreshControl.addTarget(self, action: #selector(loadMorePosts), for: .valueChanged)
        self.collectionView.refreshControl = myRefreshControl
//        tableView.rowHeight = 469
//        tableView.estimatedRowHeight = 469
    }
    @objc func loadPosts(){
        numberofPosts = 20
        let query = PFQuery(className:"Posts")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = numberofPosts
        
        query.findObjectsInBackground { (posts, error) in
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
        let query = PFQuery(className:"Posts")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = numberofPosts
        
        query.findObjectsInBackground { (posts, error) in
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
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return posts.count
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postGridCell", for: indexPath) as! postGridCell
        
            let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        
       // cell.captionLabel.text = post["caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        
        let urlString = imageFile.url!
        
        let url = URL(string: urlString)!
        
        cell.postImage.af_setImage(withURL: url)
    
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
