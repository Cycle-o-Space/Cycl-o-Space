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
            .circleRotationAnimation()
            .radius(450) // The radius of the circle
            .rotateDirection(.clockwise) // Direction of rotation.
            .itemRotationEnabled(true) // Whether the item rotates or not.
           // .cornerRadius()
//
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//
//        layout.minimumLineSpacing = 55
//
//        layout.minimumInteritemSpacing = 10
//
//        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 2
//
//        layout.itemSize = CGSize(width: width, height: width * 3 / 2)

    }
    
//    override func viewDidLayoutSubviews() {
//
//           super.viewDidLayoutSubviews()
//
//           flowLayout.minimumLineSpacing = 30
//
//           flowLayout.minimumInteritemSpacing = 5
//
//        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//      }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let totalwidth = collectionView.bounds.size.width;
//
//        let numberOfCellsPerRow = 1
//
//        let oddEven = indexPath.row % 2
//
//        let dimensions = CGFloat(Int(totalwidth) / numberOfCellsPerRow)
//
//        if (oddEven == 0) {
//           // flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//            return CGSize(width: dimensions , height: dimensions )
//        } else {
//          //  flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//            return CGSize(width: dimensions , height: dimensions )
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)



        myRefreshControl.addTarget(self, action: #selector(loadMorePosts), for: .valueChanged)
        self.collectionView.refreshControl = myRefreshControl

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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let post = posts[indexPath.row]
        

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postGridCell", for: indexPath) as! postGridCell
        self.collectionView.animateCell(cell)
                
        
            let user = post["author"] as! PFUser
        
        cell.usernameLabel.text = user.username
        
        // cell.profilePhoto.image =
        
     //  cell.captionLabel.text = post["caption"] as? String
        
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
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        
        // Pass the selected object to the new view controller.
 //   }


}
