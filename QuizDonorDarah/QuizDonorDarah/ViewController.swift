//
//  ViewController.swift
//  QuizDonorDarah
//
//  Created by Jun  on 11/8/17.
//  Copyright © 2017 Arjuna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelrencana: UILabel!
    @IBOutlet weak var labeljam: UILabel!
    @IBOutlet weak var labelalamat: UILabel!
    @IBOutlet weak var labelname: UILabel!
    
    
    var passname:String?
    var passalamat:String?
    var passjam:String?
    var passrencana:String?
    
    
    override func viewDidLoad() {
        labelname.text = passname!
        labelalamat.text = passalamat!
        labeljam.text = passjam!
        labelrencana.text = passrencana!
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

