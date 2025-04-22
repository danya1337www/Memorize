//
//  MemoryViewController.swift
//  Memorize
//
//  Created by Danil Chekantsev on 18.04.2025.
//

import UIKit

class MemoryViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    let visibleText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)!,
        .foregroundColor: UIColor.black
    ]
    
    let invisibleText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)!,
        .foregroundColor: UIColor.clear,
        .strikethroughStyle: 1,
        .strikethroughColor: UIColor.black,
        
    ]
    
    var blankCounter = 0
    var item: MemoryItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(wordsTapped))
        textView.addGestureRecognizer(tapRecognizer)
        
        assert(item != nil, "You must provide an item before trying to show this view controller.")
        
        showText()
    }
    
    func showText() {
        let words = item.text.components(separatedBy: " ")
        let output = NSMutableAttributedString()
        
        let space = NSAttributedString(string: " ", attributes: visibleText)
        
        for (index, word) in words.enumerated() {
            if index < blankCounter {
                // this word should be visible
                
                let attributedWord = NSAttributedString(string: "\(word)", attributes: visibleText)
                output.append(attributedWord)
            } else {
                // this word should be invisible
                var strippedWord = word
                var punctuation: String?
                
                if ".,".contains(word.last!) {
                    punctuation = String(strippedWord.removeLast())
                }
                
                let attributedWord = NSAttributedString(string: "\(strippedWord)", attributes: invisibleText)
                
                if let symbol = punctuation {
                    let attributedPunctuation = NSAttributedString(string: symbol, attributes: visibleText)
                    output.append(attributedPunctuation)
                }
                output.append(attributedWord)
            }
            output.append(space)
        }
        
        textView.attributedText = output
    }
    
    @objc func wordsTapped() {
        blankCounter += 1
        showText()
    }
}
