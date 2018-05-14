//
//  EditDescriptionViewController.swift
//  Movies
//
//  Created by Duje Medak on 14/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class EditDescriptionViewController: UIViewController {

    var editDelegate:EditViewControllerDelegate?
    
    
    
    
    convenience init() {
        self.init(editDelegate: nil)
    }
    
    init(editDelegate: EditViewControllerDelegate?) {
        self.editDelegate = editDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
