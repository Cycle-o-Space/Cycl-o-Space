//
//  LogInViewController.swift
//  Cycl-o-Space
//
//  Created by Kervens Delpe on 10/22/21.
//

import UIKit
import Parse

class LogInViewController: UIViewController {
    
    
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var indicatorSignin: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = username.text!
        let password = password.text!

        self.indicatorSignin.startAnimating()
        PFUser.logInWithUsername(inBackground: username, password: password) {
          (user: PFUser?, error: Error?) -> Void in
            self.indicatorSignin.stopAnimating()
          if user != nil {
            //self.displayAlert(withTitle: "Login Successful", message: "")
              let main = UIStoryboard(name: "Main", bundle: nil)
              let mainTabBar = main.instantiateViewController(identifier: "MainTabBar")
              
              guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let delegate = windowScene.delegate as? SceneDelegate else {return}
              
              delegate.window?.rootViewController = mainTabBar
                  
          } else {
            self.displayAlert(withTitle: "Incorrect Username or Password. Please try again!", message: error!.localizedDescription)
              let main = UIStoryboard(name: "Main", bundle: nil)
              let loginNavigationController = main.instantiateViewController(identifier: "LoginNavigationController")
          }
        }

    }
    
    func displayAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
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
