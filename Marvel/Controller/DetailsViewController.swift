//
//  DetailsViewController.swift
//  Marvel
//
//  Created by Carbon on 02/12/2018.
//

import UIKit

class DetailsViewController: UIViewController {

    var result: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = result.name
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
