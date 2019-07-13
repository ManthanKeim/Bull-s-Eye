//
//  ViewController.swift
//  Bull's eye
//
//  Created by Manthan Keim on 19/06/19.
//  Copyright © 2019 Manthan Keim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue =  0
    var targetValue  = 0
    var score = 0
    var round = 1
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        roundLabel.text = "1"
        startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
    
        let thumbImageHiglhited = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHiglhited, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResize = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResize, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResize = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResize, for: .normal)
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points  = 100 - difference
        
        if difference == 0 {
            score += points + 100
        }else if difference == 1 {
            score += points + 50
        }else{
            score += points
        }
        
        let title: String
        if difference == 0 {
            title = "Perfect! "
        }else if difference<5 {
            title = "Almost there!"
        }else if difference<10 {
            title = "Pretty Good!"
        }else{
            title = "Not even close!! :( "
        }
        
        
        let message: String
        if difference == 0 {
            message = "You scored \(points + 100 ) points"
        }else if difference == 1 {
            message = "You scored \(points + 50 ) points"
        }else{
            message = "You scored \(points) points"
        }
        
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        updateScore()
        
    }
    
    @IBAction func sliderMoved(  slider: UISlider)    {
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        //print("The value of the slider is now: \(slider.value)")
        //      print("The value of the slider is now: \(roundedValue)")
    }
    
    func startNewRound()    {
        
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateTarget()
    }
    
    func updateTarget(){
        target.text = String(targetValue)
    }
    
    func updateScore(){
        scoreLabel.text = String(score)
    }
    
    @IBAction func reset() {
        round += 1
        scoreLabel.text = "0"
        roundLabel.text = String(round)
    }
}

