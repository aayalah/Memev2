//
//  ViewController.swift
//  MemeMe
//
//  Created by Alejandro Ayala-Hurtado on 10/30/16.
//  Copyright © 2016 MobileApps. All rights reserved.
//

import UIKit

class ImageMemeController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let ImagePicker = UIImagePickerController()
    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var topLabelEdited = false
    var bottomLabelEdited = false
    var index = -1
    
    let memes = MemeModel.model
    
   
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setKeyboardNotifications()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        formatTextfields(label: topLabel, text: Constants().TOP)
        formatTextfields(label: bottomLabel, text: Constants().BOTTOM)
        if index != -1 {
            setUpEditView()
        }
    }
    
    
    
    
    private func setUpEditView() {
        
        topLabel.text = memes.getTopLabel(index)
        bottomLabel.text = memes.getBottomLabel(index)
        ImageView.image = memes.getOriginalImage(index)
        topLabelEdited = true
        bottomLabelEdited = true
        
    }
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
       setInitialStateOfButtons()
        
       setUpDelegates()
        
    }
   
    //Sets intial button configuration
    private func setInitialStateOfButtons() {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        actionButton.isEnabled = index != -1
        cancelButton.isEnabled = true
        
    }
    

    
    //Formats a textfield
    private func formatTextfields(label: UITextField, text: String) {
        label.borderStyle = .none
        label.defaultTextAttributes = Constants().MEME_TEXT_ATTRIBUTES
        label.text = text
        label.textAlignment = .center
    }
    
    //Sets up the delegates
    private func setUpDelegates() {
        ImagePicker.delegate = self

    }
    
    //Adds notifications to keyboard events
    private func setKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    //Removes subscription to the notifications
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self,name: .UIKeyboardWillHide, object: nil)
    }
    
    //Moves view when keyboar appears
    @objc private func keyboardWillShow(notification: Notification) {
        if !topLabel.isFirstResponder{
            self.view.frame.origin.y = -calculateKeyboardHeight(notification: notification)
        }

    }
    
    //Moves view when keyboard is disappears
    @objc private func keyboardWillHide(notification: Notification) {
        
        self.view.frame.origin.y = 0

    }
    
    //Calculates the height of the keyboard
    private func calculateKeyboardHeight(notification: Notification) -> CGFloat {
        let userInfo  = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue ).cgRectValue
        return keyboardScreenEndFrame.height
    }

    //Creates a meme
    private func generateMeme() -> UIImage {
        navBar.isHidden = true
        toolBar.isHidden = true
        
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, true, 0.0)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        navBar.isHidden = false
        toolBar.isHidden = false
        return memedImage
    }
    
    //Brings up the activity view and passes the generated meme to it
    @IBAction func displayActivityView(_ sender: UIBarButtonItem) {

        let meme = generateMeme()
        let controller = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        controller.completionWithItemsHandler = {activity, success, items, error in
            if success {
                self.saveMeme(image: meme)
            }
            
        }
        present(controller, animated: true, completion: nil)

    }
    
    //Saves the meme, though  at the moment it does not do anything, will be changed in the next version
    private func saveMeme(image: UIImage) {
        if index == -1 {
            
            memes.addImage(topLabel: topLabel.text!, bottomLabel: bottomLabel.text!, originalImage: ImageView.image!, memedImage: image)
        } else {
            memes.replaceImage(topLabel: topLabel.text!, bottomLabel: bottomLabel.text!, originalImage: ImageView.image!, memedImage: image, index: index)
        }
       
        performSegue(withIdentifier: "showMemes", sender: nil)
   
    }

    //Brings up the photo library
    @IBAction func displayPhotoLibrary(_ sender: UIBarButtonItem) {
    
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)) {
            if let mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.photoLibrary) {
                ImagePicker.mediaTypes = mediaTypes
            }
            present(ImagePicker, animated: true, completion: nil)
            
        }
   
    }
    
    
    //Brings up the camera
    @IBAction func displayCamera(_ sender: UIBarButtonItem) {

        if(cameraButton.isEnabled) {
            if let mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.camera) {
                ImagePicker.mediaTypes = mediaTypes
            }
            present(ImagePicker, animated: true, completion: nil)
            
        }
     
    }
    
    //Captures image that has been taken/chosen from camera or photo library
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        ImageView.image = selectedImage
        ImageView.contentMode = .scaleAspectFit
        dismiss(animated: true, completion: nil)
        actionButton.isEnabled = true
        cancelButton.isEnabled = true
        
    }

    //Determines whether text in textfield has been edited or not. If it has not the text is cleared
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(ImageView.image == nil) {
            return false
        }
        if (textField.tag == 0 && !topLabelEdited) {
            textField.text = ""
            topLabelEdited = true
        } else if (textField.tag == 1 && !bottomLabelEdited) {
            textField.text = ""
            bottomLabelEdited = true
        }
        cancelButton.isEnabled = true
        return true
        
    }
    
    //clears text field
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    //Dismisses keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

