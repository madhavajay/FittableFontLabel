//
//  ViewController.swift
//  FittableLabel
//
//  Created by Tom Baranes on 20/01/16.
//  Copyright © 2016 Recisio. All rights reserved.
//

import UIKit
import FittableFontLabel

class ViewController: UIViewController {

    // MARK: Properties IB
    
    @IBOutlet weak var autoFittableLabel: FittableFontLabel! {
        didSet {
            setupLabel(autoFittableLabel)
        }
    }
    
    @IBOutlet weak var labelFittableWidthAndHeight: UILabel! {
        didSet {
            labelFittableWidthAndHeight.text = words[0]
            setupLabel(labelFittableWidthAndHeight)
        }
    }
    
    @IBOutlet weak var labelFittableWidth: UILabel!  {
        didSet {
            setupLabel(labelFittableWidth)
            labelFittableWidth.text = words[0..<3].joinWithSeparator(" ")
        }
    }
    
    @IBOutlet weak var attributedLabelFittable: UILabel!  {
        didSet {
            setupLabel(attributedLabelFittable)
            attributedLabelFittable.text = words[0]
        }
    }

    @IBOutlet weak var autoFittableLabelWithInsets: FittableFontLabel! {
        didSet {
            setupLabel(autoFittableLabelWithInsets)
        }
    }
    
    // MARK: Properties 
    
    let words = [String](["apple", "orange", "banana", "grape", "kiwi", "mango", "lychee", "lemon", "coconut", "pear", "pineapple", "peach", "strawberry", "fig", "lime", "papaya", "nectarine", "plum", "quince", "raspberry", "ohajiki", "watermelon", "blackberry", "cherry", "avocado"])
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.7, target: self, selector: #selector(reloadLabels), userInfo: nil, repeats: true);
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        
        
        self.view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
    }
    
    private func setupLabel(label: UILabel) {
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.redColor().CGColor
        label.layer.cornerRadius = 3.0
    }
    
    // MARK: 
    
    func reloadLabels() {
        let random = Int(arc4random_uniform(UInt32(self.words.count)))
        labelFittableWidthAndHeight.text = String(format: "%@ %@", labelFittableWidthAndHeight.text!, words[random])
        labelFittableWidthAndHeight.fontSizeToFit(maxFontSize: 50)
        autoFittableLabel.text = labelFittableWidthAndHeight.text
        autoFittableLabelWithInsets.text = labelFittableWidthAndHeight.text
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 10.0
        paragraph.alignment = .Center
        let attributes = [NSParagraphStyleAttributeName: paragraph]
        let attributedText = NSAttributedString(string: labelFittableWidthAndHeight.text!, attributes: attributes)
        attributedLabelFittable.attributedText = attributedText
        attributedLabelFittable.fontSizeToFit(maxFontSize: 50)
        
        let screenWidth = labelFittableWidth.window!.screen.bounds.width
        let newWidth = CGFloat(arc4random()) % (screenWidth - 50.0)
        labelFittableWidth.frame.size.width = newWidth
        labelFittableWidth.fontSizeToFit(maxFontSize: 50)
    }

}
