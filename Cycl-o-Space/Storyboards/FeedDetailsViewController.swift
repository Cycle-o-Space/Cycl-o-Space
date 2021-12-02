//
//  FeedDetailsViewController.swift
//  Cycl-o-Space
//
//  Created by Kervens Delpe on 11/28/21.
//

import UIKit
import Parse
import MessageInputBar

class FeedDetailsViewController: UIViewController, MessageInputBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var selectedPostImage: UIImageView!
    
    @IBOutlet weak var postUsernameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var userProfilePicture: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var favoriteCount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var posts = [PFObject]()
    
    var currentUser = PFUser.current()
    
    var selectedPost: PFObject!
    
    
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let post = PFObject(className: "selectedPost")
        
        post["author"] = PFUser.current()?.username
        post["caption"] = captionLabel.text!
        
        
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 105
        
    }
    @objc func keyboardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()

    }
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell

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
