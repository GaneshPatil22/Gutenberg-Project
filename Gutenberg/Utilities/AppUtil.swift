//
//  Enum.swift
//  Gutenberg
//
//  Created by MacMini 20 on 8/25/20.
//  Copyright © 2020 MacMini 20. All rights reserved.
//

import UIKit

class AppUtil {

    class func getCategories() -> [CategoryModel] {
        var categories: [CategoryModel] = []
        
        let Fiction = CategoryModel(name: Constants.Fiction.rawValue, imageName: SVGImageName.Fiction.rawValue)
        let Drama = CategoryModel(name: Constants.Drama.rawValue, imageName: SVGImageName.Drama.rawValue)
        let Humor = CategoryModel(name: Constants.Humor.rawValue, imageName: SVGImageName.Humour.rawValue)
        let Politics = CategoryModel(name: Constants.Politics.rawValue, imageName: SVGImageName.Politics.rawValue)
        let Philosophy = CategoryModel(name: Constants.Philosophy.rawValue, imageName: SVGImageName.Philosophy.rawValue)
        let History = CategoryModel(name: Constants.History.rawValue, imageName: SVGImageName.History.rawValue)
        let Adventure = CategoryModel(name: Constants.Adventure.rawValue, imageName: SVGImageName.Adventure.rawValue)

        categories = [Fiction, Drama, Humor, Politics, Philosophy, History, Adventure]
        
        return categories
    }
    
    class func showMessage(_ messageText:String, messageTitle:String, buttonTitle:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: messageTitle, message: messageText, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
            var topVC = UIApplication.shared.keyWindow?.rootViewController
            while((topVC!.presentedViewController) != nil){
                 topVC = topVC!.presentedViewController
            }
            topVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    // get color using hex color code.
    class func hexStringToUIColor (hex:String, alpha: CGFloat = 1) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}
