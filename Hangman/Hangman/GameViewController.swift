//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit
extension UILabel {
    func addCharactersSpacing(spacing:CGFloat, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, text.characters.count))
        self.attributedText = attributedString
    }
}
class GameViewController: UIViewController {

    @IBOutlet var UIarray: UILabel!
    @IBAction func UInewGame(_ sender: AnyObject) {
        UIguess.isUserInteractionEnabled = true
        UIarray.text = ""
        newPhrase = ""
        guessedResult = ""
        UIhangman.image = UIImage(named: "hangman1.gif")
        self.UIwrong.text = "0"
        self.UIguess.text = ""
        viewDidLoad()
    }
    @IBOutlet var UIhangman: UIImageView!
    @IBOutlet var UIwrong: UILabel!
    @IBAction func UIbutton(_ sender: AnyObject) {
        var lst = Array(newPhrase.characters)
        if (self.UIguess.text?.characters.count)! > 1 || self.UIguess.text!.uppercased() < "A" || self.UIguess.text!.uppercased() > "Z"{
            print("Error: can only enter one character")
            let alert = UIAlertController(title: "Error", message: "can only enter one character", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else{
            
            var contains = false
            
            for (i,item) in newPhrase.characters.enumerated(){
                
                if String(lst[lst.index(lst.startIndex, offsetBy: i)]) == self.UIguess.text?.uppercased(){
                    guessedResult = "\((guessedResult as NSString).substring(to: i))" + "\(self.UIguess!.text!)"
                        + "\((guessedResult as NSString).substring(from: i+1))"
                    contains = true
                    
                }
                
            }
            if guessedResult.uppercased() == newPhrase{
                let alert = UIAlertController(title: "Congratulations!", message: "You just won the game", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                self.UIguess.text = ""
                UIguess.isUserInteractionEnabled = false

            }
            if contains == false{
                var input:Int = (UIwrong.text! as NSString).integerValue
                input += 1
                self.UIwrong.text = String(input )
                if input == 0{
                    UIhangman.image = UIImage(named: "hangman1.gif")
                }
                if input == 1{
                    UIhangman.image = UIImage(named: "hangman2.gif")
                }
                if input == 2{
                    UIhangman.image = UIImage(named: "hangman3.gif")
                }
                if input == 3{
                    UIhangman.image = UIImage(named: "hangman4.gif")
                }
                if input == 4{
                    UIhangman.image = UIImage(named: "hangman5.gif")
                }
                if input == 5{
                    UIhangman.image = UIImage(named: "hangman6.gif")
                }
                if input == 6{
                    UIhangman.image = UIImage(named: "hangman7.gif")
                }
                if input > 6{
                    let alert = UIAlertController(title: "The End", message: "Sorry, you just lost :(", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    UIguess.isUserInteractionEnabled = false
                    self.UIguess.text = ""
                    UIguess.isUserInteractionEnabled = false
                    
                }
                if self.UIarray.text == ""{
                    self.UIarray.text = self.UIarray.text! +  self.UIguess.text!
                }
                else{
                    self.UIarray.text = self.UIarray.text! + ", " + self.UIguess.text!
                }
                
            }
            self.UIword?.text = guessedResult
            self.UIword.addCharactersSpacing(spacing: 5, text: guessedResult)

        }
    }
    
    var newPhrase = ""
    var guessedResult = ""
    
    @IBOutlet var UIword: UILabel!
    
    
    
    @IBOutlet var UIguess: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        
        
        for i in (phrase?.characters.indices)!{
            if phrase?[i] != " "{
                
                guessedResult = guessedResult + "_"
                
            }
            else{
                guessedResult = guessedResult + " "
                
            }
        }
        newPhrase = phrase!
        
        
        
        self.UIword?.text = guessedResult
        self.UIword.addCharactersSpacing(spacing: 5, text: guessedResult)

       
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
