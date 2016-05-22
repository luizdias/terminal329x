//
//  ViewController.swift
//  terminal329x
//
//  Created by Luiz Fernando Aquino Dias on 5/21/16.
//  Copyright © 2016 Luiz Fernando Aquino Dias. All rights reserved.
//

import UIKit
import RUSwiftTypewriterLabel
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var npcMessage: UILabel!
    @IBOutlet weak var playerMessage: UILabel!
    
    @IBOutlet weak var firstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var connectedLabel: UILabel!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    let typeSpeed = 0.08
    var saveState = 0
//    print("The savestate is now= \(saveState)")
    
    var story:JSON = JSON.null
    
    @IBAction func nextActionButton(sender: UIButton) {
        reNew()
    }
    @IBAction func firstActionButton(sender: UIButton) {
        let mutableString = generateMutableAttributedString(getFirstButtonMessage().message)
        saveState = getFirstButtonMessage().action
        print("saveState=\(saveState)")
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(saveState, forKey: "saveState")
        startTyping(mutableString, typeSpeed: typeSpeed, label: playerMessage)
        playerActionTasks()
    }
    
    @IBAction func secondActionButton(sender: UIButton) {
        let mutableString = generateMutableAttributedString(getSecondButtonMessage().message)
        saveState = getSecondButtonMessage().action
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(saveState, forKey: "saveState")
        startTyping(mutableString, typeSpeed: typeSpeed, label: playerMessage)
        playerActionTasks()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("saveState antes=\(saveState)")
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(saveState, forKey: "saveState")
        print("saveState depois setar defaults=\(saveState)")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        saveState = defaults.integerForKey("saveState")
        
        story=getStory()
        
        npcMessage.font = UIFont(name: "Monaco", size: 16)
        playerMessage.font = UIFont(name: "Monaco", size: 16)
        gameNameLabel.font = UIFont(name: "Monaco", size: 13)
        connectedLabel.font = UIFont(name: "Monaco", size: 13)
        statusLabel.font = UIFont(name: "Monaco", size: 13)
        view.backgroundColor = UIColor.grayColor()
        
        self.playerMessage.text = ""
        self.npcMessage.text = ""
        nextButton.hidden = true
        firstAnswerButton.setTitle(getFirstButtonMessage().message, forState: UIControlState.Normal)
        secondAnswerButton.setTitle(getSecondButtonMessage().message, forState: UIControlState.Normal)
        
        npcMessage.textAlignment = .Left
        npcMessage.adjustsFontSizeToFitWidth = true
        
        let mutableString = generateMutableAttributedString(getNpcMessage())
        
        startTyping(mutableString, typeSpeed: typeSpeed, label: npcMessage)
    }
    
    func generateMutableAttributedString(inputString: String) -> NSMutableAttributedString {
        let mutedString = NSMutableAttributedString(string: inputString)
                
        return mutedString
    }
    
    func getNpcMessage() -> String {
        let line1 = story["story"][saveState]["line1"].string
        let line2 = story["story"][saveState]["line2"].string

        return line1! + " " + line2!
    }
    
    
    func getFirstButtonMessage() -> (message: String, action: Int) {
        let line1 = story["story"][saveState]["optionOneTextline1"].string
        let line2 = story["story"][saveState]["optionOneTextline2"].string
        let action = story["story"][saveState]["optionOneway"].number
        
        let max = 5
        if action?.integerValue == max {
            saveState = 0
        } else {
            saveState = (action?.integerValue)!
        }
        
        let message = line1! + " " + line2!
        return (message, action as! Int)
    }

    func getSecondButtonMessage()-> (message: String, action: Int) {
        let line1 = story["story"][saveState]["optionTwoTextline1"].string
        let line2 = story["story"][saveState]["optionTwoTextline2"].string
        let action = story["story"][saveState]["optiontwoway"].number

        let max = 5
        if action?.integerValue == max {
            saveState = 0
        } else {
            saveState = (action?.integerValue)!
        }
        

        
        let message = line1! + " " + line2!
        return (message, action as! Int)
    }
    
    func getStory() -> JSON {
        
        let jsonFilePath:NSString = NSBundle.mainBundle().pathForResource("story", ofType: "json")!

        do {
            let jsonString = try String(contentsOfFile: jsonFilePath as String, encoding: NSUTF8StringEncoding)
            if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                print("\(json)")
                return json
            }
        } catch let error as NSError {
            print("error loading from url \(jsonFilePath)")
            print(error.localizedDescription)
        }

        return JSON.null
    }
    
    func playerActionTasks(){

        //hidding the two possible answer buttons. Showing the "Next" button
        firstAnswerButton.hidden = true
        secondAnswerButton.hidden = true
        nextButton.hidden = false

        //Saves the current state
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(saveState, forKey: "saveState")
    }
    
    func reNew(){
        //reload application data (renew root view)
        UIApplication.sharedApplication().keyWindow?.rootViewController = storyboard!.instantiateViewControllerWithIdentifier("Main")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

protocol MainViewDelegate {
    func viewString() -> String;
}

