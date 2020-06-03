//
//  TheDelegateHere.swift

//
//  Created by Stephen Bodnar on 04/04/2017.
//  Copyright © 2020 Johan van Rhyn. All rights reserved.
//

import Foundation
import UIKit

protocol PicSpltDelegate {
    func didFinishCroppingImage(_ croppedImage: UIImage)
    func didFailWithError(_ error: NSError)
    func cancelButtonWasPressed()
}
