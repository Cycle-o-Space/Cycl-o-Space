//
//  ProfileViewController.swift
//  Cycl-o-Space
//
//  Created by Kervens Delpe on 11/22/21.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITabBarDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var profileUsername: UILabel!
    
    @IBOutlet weak var PostDetails: UIView!
    
    @IBOutlet weak var PreviousRoutesDetails: UIView!
    
    @IBOutlet weak var Favorited: UIView!
    
    @IBOutlet weak var tabDetailsSwitch: UISegmentedControl!
    
    @IBOutlet weak var stackView: UIStackView!
    
    var posts = [PFObject]()
    
    var currentUser = PFUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostDetails.isHidden = false
        PreviousRoutesDetails.isHidden = true
        Favorited.isHidden = true
        
        self.profileUsername.text = currentUser?.username

    }

    @IBAction func tabSwitch(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
    case 0:
            PostDetails.isHidden = false
            PreviousRoutesDetails.isHidden = true
            Favorited.isHidden = true
        
    case 1:
            PostDetails.isHidden = true
            PreviousRoutesDetails.isHidden = false
            Favorited.isHidden = true
     
    case 2:
            PostDetails.isHidden = true
            PreviousRoutesDetails.isHidden = true
            Favorited.isHidden = false
        
    default:
            break;

    }
    }
    
    @IBAction func onProfilePicCamera(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
   
        present(picker, animated: true, completion: nil)
        
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
