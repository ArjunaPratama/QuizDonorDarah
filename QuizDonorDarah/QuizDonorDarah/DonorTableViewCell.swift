//
//  DonorTableViewCell.swift
//  QuizDonorDarah
//
//  Created by Jun  on 11/8/17.
//  Copyright © 2017 Arjuna. All rights reserved.
//

import UIKit

class DonorTableViewCell: UITableViewCell {

    @IBOutlet weak var lblrencana: UILabel!
    @IBOutlet weak var lbljam: UILabel!
    @IBOutlet weak var lblalamat: UILabel!
    @IBOutlet weak var lblname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
