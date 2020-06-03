//
//  ViewController.swift
//  PicSpltDemo
//
//  Created by Stephen Bodnar on 08/04/2017.
//  Copyright © 2020 Johan van Rhyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func showCircleCropVC(sender: UIButton) {
        let image = UIImage(named: "beach")!
        let circleVC = PicSpltCircularVC(circleRadius: 158, withImageToCrop: image)
        circleVC.delegate = self
        self.present(circleVC, animated: true, completion: nil)
    }
    
    @IBAction func showRectangleCropVC(sender: UIButton) {
        let image = UIImage(named: "beach")!
        let width = UIScreen.main.bounds.width
        
        let rect = CGRect(x: 10, y: 150, width: width, height: width / 2)
        let rectVC = PicSpltRectangularVC(croppingRect: rect, withImageToCrop: image)
        rectVC.delegate = self
        self.present(rectVC, animated: true, completion: nil)
    }

}

extension ViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if (info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage) != nil {
            // If you are using PicSplt with UIImagePickerController, here is where you
            // will present either PicSpltCircularVC or PicSpltRectangularVC, passing in pickedImage as the image to crop
        }
    }
}

extension ViewController: PicSpltDelegate {
    func cancelButtonWasPressed() {
        print("cancel was pressed")
        self.dismiss(animated: true, completion: nil)
    }
    
    func didFailWithError(_ error: NSError) {
        print("failed with error")
    }
    
    func didFinishCroppingImage(_ croppedImage: UIImage) {
        imageView.image = croppedImage
        self.dismiss(animated: true, completion: nil)
    }
}

