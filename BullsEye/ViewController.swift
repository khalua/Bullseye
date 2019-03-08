//
//  ViewController.swift
//  BullsEye
//
//  Created by Tony Contreras on 2/10/19.
//  Copyright © 2019 Orbit Networks. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // these are intance methods
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    var audioPlayer: AVAudioPlayer?

    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "sliderBackgroundDefault")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "sliderBackgroundInverse")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "leftTrackImage")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "rightTrackImage-1")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        do {
            if let audioPath = Bundle.main.path(forResource: "fart", ofType: "wav") {
                let url = URL(fileURLWithPath: audioPath)
                audioPlayer = try AVAudioPlayer(contentsOf: url)
            } else {
                print("No file with that name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        
    }

    
    @IBAction func showAlert() {
        
        audioPlayer?.play()
        
        let difference = abs(targetValue - currentValue) //local
        var points = 100 - difference //local

        score += points //instance
        
        let title: String //local
        if difference == 0 {
            title = "Perfect you sonofabitch!"
            points += 100
        }  else if difference == 1 {
            title = "Just 1 off!"
            points += 50
        }  else if difference < 5 {
            title = "Close!"
        } else {
            title = "You suck ass"
        }
        
        // message popup
        let message  = "You just guessed \(currentValue) and scored \(points). Your total score is \(score)" //local
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert) //local
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        }) //local
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    
    }
    // as soon as the method above is over, all the local variables are destroyed
   
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
   
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        round += 1
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    @IBAction func startNewGame(){
    round = 0
    score = 0
    startNewRound()
    //Transition BS
    let transition = CATransition()
    transition.type = CATransitionType.fade
    transition.duration = 1
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }

}
