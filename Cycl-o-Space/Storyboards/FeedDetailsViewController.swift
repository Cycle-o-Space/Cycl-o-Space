//
//  FeedDetailsViewController.swift
//  Cycl-o-Space
//
//  Created by Kervens Delpe on 11/28/21.
//

import UIKit
import Parse
import MessageInputBar

class FeedDetailsViewController: UIViewController, MessageInputBarDelegate /*, UITableViewDataSource, UITableViewDelegate*/ {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var posts = [PFObject]()
    
    var currentUser = PFUser.current()
    
    var selectedPost: PFObject!
    
    
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
//        tableView.dataSource = self
//        tableView.delegate = self
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
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return 0
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
