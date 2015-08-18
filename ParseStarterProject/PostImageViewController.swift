//
//  PostImageViewController.swift
//  ParseStarterProject
//
//  Created by Brad Gray on 8/16/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var ImageToPost: UIImageView!
    
    @IBAction func ChooseImage(sender: UIButton) {
    
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        ImageToPost.image = image
        
    }
    
    @IBOutlet weak var imageText: UITextField!
    
    
    @IBAction func postImage(sender: UIButton) {
        
       
        var post = PFObject(className: "Post")
        
        post["message"] = imageText.text
        
        post["userId"] = PFUser.currentUser()!.objectId!
        
        let imageData = UIImagePNGRepresentation(ImageToPost.image!)
        
        let imageFile = PFFile(name: "image.png", data: imageData!)
        
        post["imageFile"] = imageFile
        
        post.saveInBackgroundWithBlock{(success, error) -> Void in
    
            
            if error == nil {
                
                print("Sucess")
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
