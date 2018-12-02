//
//  ImageView.swift
//  Marvel
//
//  Created by Bruno Silva on 18/11/2018.
//

import UIKit

extension UIImageView {
    
    func loadImageUsingUrlString(urlString: String) {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { [weak self] (data, respones, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    self?.image = UIImage(data: data)
                }
            }
            
        }).resume()
    }
    
}
