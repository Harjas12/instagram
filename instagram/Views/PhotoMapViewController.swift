//
//  PhotoMapViewController.swift
//  instagram
//
//  Created by Harjas Monga on 2/3/18.
//  Copyright © 2018 Harjas Monga. All rights reserved.
//

import UIKit
import MBProgressHUD

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var postTextView: UITextView!
    
    let vc = UIImagePickerController()
    var imageToBePosted: UIImage?
    
    let placeHolderText: String = "Add your caption here..."
    let placeHolderColor: UIColor = UIColor.lightGray
    let activeTextColor: UIColor = UIColor.black

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc.delegate = self
        vc.allowsEditing = true
        
        postTextView.delegate = self
        postTextView.text = placeHolderText
        postTextView.textColor = placeHolderColor
    }
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func getImagesFromPhotos() {
        vc.sourceType = .photoLibrary
        present(vc, animated: true, completion: nil)
    }
    @IBAction func takeImagesFromPhotos(_ sender: Any) {
        getImagesFromPhotos()
    }
    @IBAction func takeImageFromCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            vc.sourceType = .camera
            present(vc, animated: true, completion: nil)
        } else {
            let alertViewController = UIAlertController(title: "Error", message: "Cannot access camera", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            let useLibrary = UIAlertAction(title: "Use Photos", style: .default, handler: { (action: UIAlertAction) in
                self.getImagesFromPhotos()
            })
            alertViewController.addAction(cancelAction)
            alertViewController.addAction(useLibrary)
            present(alertViewController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        selectedImageView.image = editedImage
        imageToBePosted = editedImage
        dismiss(animated: true, completion: nil)
    }
    @IBAction func userTappedScreen(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func userClickedShareButton(_ sender: Any) {
        if imageToBePosted == nil {
            let alertController = UIAlertController(title: "Error", message: "No Image. Please add an image", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            Post.postUserImage(image: imageToBePosted, withCaption: postTextView.text, withCompletion: { (success, error) in
                    if success {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                })
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == placeHolderColor {
            textView.text = ""
            textView.textColor = activeTextColor
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolderText
            textView.textColor = placeHolderColor
        }
    }
    func resize(image: UIImage, newSize: CGSize) -> UIImage? {
        let resizeImageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: newSize.width, height: newSize.height)))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
