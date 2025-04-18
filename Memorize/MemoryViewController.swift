//
//  MemoryViewController.swift
//  Memorize
//
//  Created by Danil Chekantsev on 18.04.2025.
//

import UIKit

class MemoryViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
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
        var output = " "
        
        for (index, word) in words.enumerated() {
            if index < blankCounter {
                output += "\(word) "
            } else {
                let blank = String(repeating: "_", count: word.count)
                output.append("\(blank) ")
            }
        }
        
        textView.text = output
    }
    
    @objc func wordsTapped() {
        blankCounter += 1
        showText()
    }
}
