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
    
    @IBOutlet weak var Favorited: UIView!
    
    @IBOutlet weak var tabDetailsSwitch: UISegmentedControl!
    
    
    var currentUser = PFUser.current()
    
    var profilePicture = [PFObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        PostDetails.isHidden = false
        Favorited.isHidden = true
        
        self.profileUsername.text = currentUser?.username
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let profilepictureQuery = PFQuery(className: "User")
        profilepictureQuery.includeKey("profileImage")
        profilepictureQuery.limit = 1
        
        profilepictureQuery.findObjectsInBackground { (profilePicture, error) in
            if profilePicture != nil {
                //self.profilePicture.removeAll()
                self.profilePicture = profilePicture!
                //self.profilePicture.reverse()
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }

    @IBAction func tabSwitch(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
    case 0:
            PostDetails.isHidden = false
            Favorited.isHidden = true
        
    case 1:
            PostDetails.isHidden = true
            Favorited.isHidden = false
     
    default:
            break;

    }
    }
    
    func loadProfilePicture() {
        
        
    }
    
    @IBAction func onProfilePicCamera(_ sender: Any) {
        
        print("selecting profile picture")
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
      let image = info[.editedImage] as! UIImage
        

        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)

        profilePic.image = scaledImage
            

        self.dismiss(animated: true, completion: nil)
        
        
    }

    
    @IBAction func setProfilePicture(_ sender: Any) {
        
        let imageData = (profilePic.image!.pngData())
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        currentUser!["profileImage"] = file
        currentUser!.saveInBackground { (success, error) in
            if (error != nil) {
               // self.dismiss(animated: true, completion: nil)

                print("saved!")
            } else {
                print ("error!")
            }
        }
        
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
