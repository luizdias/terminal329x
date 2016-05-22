//
//  ViewController.swift
//  terminal329x
//
//  Created by Luiz Fernando Aquino Dias on 5/21/16.
//  Copyright © 2016 Luiz Fernando Aquino Dias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var npcMessage: UILabel!
    @IBOutlet weak var playerMessage: UILabel!
    
    @IBOutlet weak var firstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    
    @IBAction func firstActionButton(sender: UIButton) {
        self.playerMessage.text = "Yes. I’m a machine. And you’re not? #PARTIU-PIZZA 🍕"
    }
    
    @IBAction func secondActionButton(sender: UIButton) {
        self.playerMessage.text = "No. I’m not. I’m actually talking to you."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        npcMessage.font = UIFont(name: "Monaco", size: 16)
        playerMessage.font = UIFont(name: "Monaco", size: 16)
        
        view.backgroundColor = UIColor.grayColor()
        
        self.playerMessage.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

