//
//  RectangularCropVC.swift

//
//  Created by Johan van Rhyn on 03/0162020.
//  Copyright © 2020 Johan van Rhyn. All rights reserved.
//

import Foundation
import UIKit

class PicSpltRectangularVC: ParentViewController {
    
    
    convenience init(croppingRect: CGRect, withImageToCrop image: UIImage) {
        self.init(nibName: nil, bundle: nil)
        imageToCrop = image
        self.croppingRect = croppingRect
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if PicSpltHelpers.croppingRectIsValid(croppingRect, inView: self.view) {
            setup()
        } else {
            let error = NSError(domain: "NSRectRangeException", code: 10, userInfo: [NSLocalizedDescriptionKey: "Your cropping rect is invalid. Cropping rects may not have origins less than 0, widths wider than the view's width, or height's taller than the view's height"])
            self.delegate?.didFailWithError(error)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func setup() {
        let rectangularOverlay = RectangularOverlayView(frame: view.frame, withCroppingRect: croppingRect)
        setupScrollView()
        setupPhoto()
        view.addSubview(rectangularOverlay)
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
        delegate?.didFinishCroppingImage(imageToPass)
        self.dismiss(animated: true, completion: nil)
    }

    
}
