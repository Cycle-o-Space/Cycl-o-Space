//
//  PostsDetailsViewController.swift
//  Cycl-o-Space
//
//  Created by Kervens Delpe on 11/23/21.
//

import UIKit
import Parse
import AlamofireImage

class PostsDetailsViewController: UIViewController /* UICollectionViewDelegate, UICollectionViewDataSource*/ {

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        layout.minimumLineSpacing = 55

        layout.minimumInteritemSpacing = 10

        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        

        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
