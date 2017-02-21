//
//  ViewController.swift
//  Modern Magic 8-Ball
//
//  Created by Braden Casperson on 2/20/17.
//  Copyright © 2017 Braden Casperson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainScreenView: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    
    let positiveAnswers = ["Heck yeah!", "Most Definitely", "You'd be crazy not to.", "There's a good chance.", "It's worth a shot.", "Absolutely."]
    let middleAnswers = ["Uhhh, ask me again later.", "Wow, this is a toughie. I'm going to have to think about this a little more.", "It really doesn't matter."]
    let negativeAnswers = ["Don't you dare.", "Nope, sorry.", "Probably not the best choice.", "You may as well forget you ever asked that; bad idea.", "Terrible choice.", "No. Just no."]
    var allAnswers = [[String]]()
    
    var labelStage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allAnswers = [positiveAnswers, middleAnswers, negativeAnswers]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake {
            UIView.animate(withDuration: 0.7, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.answerLabel.alpha = 0.0
                self.mainScreenView.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                
                if self.labelStage == 0 {
                    let randomArray = self.allAnswers[Int(arc4random_uniform(UInt32(self.allAnswers.count)))]
                    let randomAnswer = Int(arc4random_uniform(UInt32(randomArray.count)))
                    
                    if randomArray == self.positiveAnswers {
                        self.mainScreenView.backgroundColor = UIColor(red: 99/255.0, green: 164/255.0, blue: 255/255.0, alpha: 1.0)
                    } else if randomArray == self.middleAnswers {
                        self.mainScreenView.backgroundColor = UIColor(red: 209/255.0, green: 199/255.0, blue: 163/255.0, alpha: 1.0)
                    } else {
                        self.mainScreenView.backgroundColor = UIColor(red: 122/255.0, green: 2/255.0, blue: 2/255.0, alpha: 1.0)
                    }
                    self.answerLabel.text = randomArray[randomAnswer]
                    
                    self.labelStage = 1
                } else if self.labelStage == 1 {
                    self.mainScreenView.backgroundColor = UIColor.white
                    self.answerLabel.textColor = UIColor.black
                    self.answerLabel.text = "Not satisfied? Shake to start over."
                    self.labelStage = 2
                } else {
                    self.mainScreenView.backgroundColor = UIColor.black
                    self.answerLabel.textColor = UIColor.white
                    self.answerLabel.text = "Shake To Reveal the Answer To Your Question"
                    self.labelStage = 0
                }
                
                UIView.animate(withDuration: 0.7, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    self.answerLabel.alpha = 1.0
                    self.mainScreenView.alpha = 1.0
                }, completion: nil)
            })
        }
    }


}

