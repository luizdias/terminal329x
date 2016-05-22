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
    
    let typeSpeed = 0.08
    var saveState = 0
    
    var story:JSON = JSON.null
    
    @IBAction func firstActionButton(sender: UIButton) {
        let message = getFirstButtonMessage()
        let mutableString = generateMutableAttributedString(message)
        startTyping(mutableString, typeSpeed: typeSpeed, label: playerMessage)
        
        //hidding the two possible answer buttons
        firstAnswerButton.hidden = true
        secondAnswerButton.hidden = true
    }
    
    @IBAction func secondActionButton(sender: UIButton) {
        let message = getSecondButtonMessage()
        let mutableString = generateMutableAttributedString(message)
        startTyping(mutableString, typeSpeed: typeSpeed, label: playerMessage)

        //hidding the two possible answer buttons
        firstAnswerButton.hidden = true
        secondAnswerButton.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let initialMessage = "TTTesting keyboard. 123 OMG.. Is this piece of junk really working?"
        story=getStory()

        npcMessage.font = UIFont(name: "Monaco", size: 16)
        playerMessage.font = UIFont(name: "Monaco", size: 16)
        view.backgroundColor = UIColor.grayColor()
        
        
        self.playerMessage.text = ""
        self.npcMessage.text = ""
        
        firstAnswerButton.setTitle(getFirstButtonMessage(), forState: UIControlState.Normal)
        secondAnswerButton.setTitle(getSecondButtonMessage(), forState: UIControlState.Normal)
        
        
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
//        let actualState = story[saveState+1].dictionaryObject
//        print(actualState!["line1"] as! String)
        print(story["story"][saveState])
        
        return line1! + " " + line2!
    }
    
    
    func getFirstButtonMessage() -> String {
        let line1 = story["story"][saveState]["optionOneTextline1"].string
        let line2 = story["story"][saveState]["optionOneTextline2"].string
        //        let actualState = story[saveState+1].dictionaryObject
        //        print(actualState!["line1"] as! String)
        //        print(actualState)
        
        return line1! + " " + line2!
    }

    func getSecondButtonMessage() -> String {
        let line1 = story["story"][saveState]["optionTwoTextline1"].string
        let line2 = story["story"][saveState]["optionTwoTextline2"].string
        //        let actualState = story[saveState+1].dictionaryObject
        //        print(actualState!["line1"] as! String)
        //        print(actualState)
        
        return line1! + " " + line2!
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

