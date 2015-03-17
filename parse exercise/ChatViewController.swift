//
//  ChatViewController.swift
//  parse exercise
//
//  Created by Scott Tong on 3/16/15.
//  Copyright (c) 2015 Scott Tong. All rights reserved.
//

import UIKit
//7. import parse again
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet weak var chatTextField: UITextField!
	@IBOutlet weak var chatTableView: UITableView!
	
	var messages: [PFObject]! = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		chatTableView.delegate = self
		chatTableView.dataSource = self
		
		getMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	@IBAction func didPressSend(sender: AnyObject) {
		// 8. create a var message that is a Parse Object we call "Message"
		var message = PFObject(className: "Message")
		message["text"] = chatTextField.text
		message["user"] = PFUser.currentUser()
		message.saveInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
			self.getMessages()
			println("Saved message")
			
		}
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//
		return messages.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var message = messages[indexPath.row]
		var cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as MessageCell
		cell.messageLabel.text = message["text"] as String!
		return cell
	}
	
	// this function lets you FETCH messages from Parse
	func getMessages() {
		
		var query = PFQuery(className: "Message")
		// change the ordering of the messages
		query.addDescendingOrder("createdAt")
		
		query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
			self.messages = objects as [PFObject]
			self.chatTableView.reloadData()
		}
	}

}
