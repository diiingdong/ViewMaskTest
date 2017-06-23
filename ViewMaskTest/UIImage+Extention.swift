//
//  UIImage+Extention.swift
//  ViewMaskTest
//
//  Created by Ted Gao on 2017-06-23.
//  Copyright © 2017 ted gao. All rights reserved.
//

import Foundation
import UIKit

extension UIImage
{
    convenience init(view: UIView)
    {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}
