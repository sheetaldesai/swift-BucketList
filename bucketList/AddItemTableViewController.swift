//
//  AddItemTableViewController.swift
//  bucketList
//
//  Created by Sheetal Desai on 11/6/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    weak var delegate: AddItemTableViewControllerDelegate?
    var editItem: String?
    var indexPath: IndexPath?
    
    @IBOutlet weak var txtItem: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtItem.text = editItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    @IBAction func SaveButtonPressed(_ sender: UIBarButtonItem) {
        if let item = txtItem.text {
            delegate?.addItemViewController(self, didFinishAddingItem: item, at: indexPath)
        }
    }
    
    
    @IBAction func CancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.addItemViewController(self, didPressCancelButton: sender)
    }
}
