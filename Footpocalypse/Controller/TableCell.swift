//
//  TableViewCell.swift
//  Life Explorer
//
//  Created by Matheus Kerber Venturelli on 04/04/18.
//  Copyright © 2018 Matheus Kerber Venturelli. All rights reserved.
//

import Foundation
import UIKit

/**********************************************
 *    Célula customizada da TableView
 ***********************************************/

class TableCell: UITableViewCell {
    
//    @IBOutlet var nameLabel: UILabel?
//    @IBOutlet var thumbnailImageView: UIImageView?
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var viewSubText: UILabel!
    //  @IBOutlet weak var viewText: UILabel!
    @IBOutlet weak var viewImage: UIImageView!
    @IBOutlet weak var viewText: UILabel!
}
