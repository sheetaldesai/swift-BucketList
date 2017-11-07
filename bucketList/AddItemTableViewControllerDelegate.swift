//
//  AddItemTableViewControllerDelegate.swift
//  bucketList
//
//  Created by Sheetal Desai on 11/6/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAddingItem item: String, at indexPath:IndexPath?)
    
    func addItemViewController(_ controller: AddItemTableViewController, didPressCancelButton button: UIBarButtonItem) // Taken from CancelButtonDelegate file, and altered to match pattern.
}
