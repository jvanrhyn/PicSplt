//
//  CircularCropVC.swift

//
//  Created by Johan van Rhyn on 03/0162020.
//  Copyright © 2020 Johan van Rhyn. All rights reserved.
//

import Foundation
import UIKit

class PicSpltCircularVC: ParentViewController {
    var radius = CGFloat()
    
    convenience init(circleRadius: CGFloat, withImageToCrop image: UIImage) {
        self.init(nibName: nil, bundle: nil)
        radius = circleRadius
        self.imageToCrop = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if PicSpltHelpers.radiusIsValid(radius, inView: self.view) {
            setup()
        } else {
            let error = NSError(domain: "NSRectRangeException", code: 10, userInfo: [NSLocalizedDescriptionKey: "Your radius is invalid. The radius may not be greater than the ((width of your view) - 2)"])
            self.delegate?.didFailWithError(error)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setup() {
        let circularOverlay = CircularOverlayView(frame: view.frame, withRadius: radius)
        croppingRect = circularOverlay.croppingRectFromRadius()
        setupScrollView()
        setupPhoto()
        view.addSubview(circularOverlay)
        addSaveButton()
        addCancelButton()
    }
    
    func addSaveButton() {
        let button = UIButton(frame: CGRect(x: (self.view.frame.width - 70), y: 20, width: 75, height: 30))
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 21)
        button.setTitle("Save", for: UIControl.State())
        button.addTarget(self, action: #selector(save), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.sizeToFit()
        self.view.addSubview(button)
    }
    
    @objc func save() {
        
        let roundedImage = imageToPass.circularImage(imageToPass.size.width / 2)
        delegate?.didFinishCroppingImage(roundedImage)
    }
    
}
