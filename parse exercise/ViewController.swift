//
//  ViewController.swift
//  parse exercise
//
//  Created by Scott Tong on 3/16/15.
//  Copyright (c) 2015 Scott Tong. All rights reserved.
//

import UIKit
// 1. import parse
import Parse

class ViewController: UIViewController {

	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var usernameTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func didPressLoginButton(sender: AnyObject) {
		// 6. How to log in
		PFUser.logInWithUsernameInBackground(usernameTextField.text, password: passwordTextField.text) { (user: PFUser!, error: NSError!) -> Void in
			// check for errors
			if user != nil {
				println("Logged in!")
				self.performSegueWithIdentifier("loginSegue", sender: self)
			}
			else {
				println(error.description)
			}
		}
	}
	
	@IBAction func didPressSignup(sender: AnyObject) {
		// 2.  create a user. Steps 3 and 4 live on AppDelegate.swift
		
		var user = PFUser() // parse gives it to us out of the box
		user.username = usernameTextField.text
		user.password = passwordTextField.text
		
		// 5. check for errors, like if the username is already taken
		user.signUpInBackgroundWithBlock { (success: Bool, error: NSError!) -> Void in
			if success {
				self.performSegueWithIdentifier("loginSegue", sender: self)
			}
			else  {
				var alertView = UIAlertView(title: "Oops", message: error.description, delegate: nil, cancelButtonTitle: "OK")
				alertView.show()
			}
			println("User created")
		}
	}
	

}

