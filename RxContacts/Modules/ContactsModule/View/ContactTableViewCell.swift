//
//  ContactTableViewCell.swift
//  RxContacts
//
//  Created by user177273 on 3/8/21.
//

import Foundation
import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactLastName: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var contactPhone: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}
