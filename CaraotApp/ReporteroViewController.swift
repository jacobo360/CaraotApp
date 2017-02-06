//
//  ReporteroViewController.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 10/13/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import UIKit
import MessageUI

class ReporteroViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, MFMailComposeViewControllerDelegate {

    var picker = UIImagePickerController()
    var mailComposer = MFMailComposeViewController()
    
    @IBOutlet weak var fotoView: UIImageView!
    @IBOutlet weak var camIconView: UIStackView!
    @IBOutlet weak var txtField: UITextView!
    @IBOutlet weak var sendBtnOut: UIButton!
    @IBOutlet weak var clickView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.isNavigationBarHidden = false
        
        txtField.layer.cornerRadius = 7
        sendBtnOut.layer.cornerRadius = 7
        
        txtField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ReporteroViewController.handleTap))
        tap.delegate = self
        clickView.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func sendBtnAct(_ sender: AnyObject) {
        Mailer().setupMail(attachment: UIImageJPEGRepresentation(fotoView.image!, 1)!, body: txtField.text, mailComposer: mailComposer)
        mailComposer.mailComposeDelegate = self
        self.present(mailComposer, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        mailComposer = MFMailComposeViewController()
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleTap() {
        txtField.resignFirstResponder()
        
        let alert:UIAlertController=UIAlertController(title: "Escoge una Imagen", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Tomar Foto", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Abrir Galería", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            picker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(picker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"Error", message: "No pudímos accesar tu camara, por favor revisa tus configuraciones y permisos", delegate: nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            alertWarning.show()
        }
    }
    
    func openGallery()
    {
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker .dismiss(animated: true, completion: nil)
        fotoView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        fotoView.layer.shadowColor = UIColor.black.cgColor
        fotoView.layer.shadowOpacity = 1
        fotoView.layer.shadowOffset = CGSize.zero
        fotoView.layer.shadowRadius = 2
        camIconView.isHidden = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("picker cancel.")
    }

}
