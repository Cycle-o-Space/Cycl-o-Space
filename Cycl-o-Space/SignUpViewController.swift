//
//  SignUpViewController.swift
//  Cycl-o-Space
//
//  Created by Kervens Delpe on 11/20/21.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var createUsername: UITextField!
    
    @IBOutlet weak var createPassword: UITextField!
    
    @IBOutlet weak var indicatorSignup: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSIgnUp(_ sender: Any) {
        let user = PFUser()
        user.username = createUsername.text
        user.password = createPassword.text
        
        self.indicatorSignup.startAnimating()
                user.signUpInBackground {(succeeded: Bool, error: Error?) -> Void in
                    self.indicatorSignup.stopAnimating()
                    if let error = error {
                        self.displayAlert(withTitle: "Error", message: error.localizedDescription)
                    } else {
                        self.displayAlert(withTitle: "Success", message: "Account has been successfully created")
                        let main = UIStoryboard(name: "Main", bundle: nil)
                        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
                        
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                              let delegate = windowScene.delegate as? SceneDelegate else {return}
                        
                        delegate.window?.rootViewController = loginViewController
                    }
                }
        
    }
    func displayAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
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
