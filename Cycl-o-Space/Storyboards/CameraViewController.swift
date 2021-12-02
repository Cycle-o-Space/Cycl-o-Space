//
//  CameraViewController.swift
//  Cycl-o-Space
//
//  Created by Kervens Delpe on 11/21/21.
//

import UIKit
import Parse
import AlamofireImage

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var captionField: UITextField!
    
    
    var postPicker = UIImagePickerController()

    var profilePicturePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let postPicker = UIImagePickerController()
        postPicker.delegate = self
        postPicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            postPicker.sourceType = .camera
        } else {
            postPicker.sourceType = .photoLibrary
        }
   
        present(postPicker, animated: true, completion: nil)
    }
    
    
    
    @IBAction func onSubmitButton(_ sender: Any) {
        
        let post = PFObject(className: "Posts")
        
        post["caption"] = captionField.text!
        post["author"] = PFUser.current()!
        let postQuery = PFQuery(className:"Posts")
        if let user = PFUser.current() {
          postQuery.whereKey("author", equalTo: user)
        }
        let imageData = (imageView.image!.pngData())
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["image"] = file
        
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)

                print("saved!")
            } else {
                print ("error!")
            }
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
      let image = info[.editedImage] as! UIImage
        

        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)

        imageView.image = scaledImage
            

        self.dismiss(animated: true, completion: nil)

    }
    

    @IBAction func goBackButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
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
