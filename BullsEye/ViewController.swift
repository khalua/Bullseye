//
//  ViewController.swift
//  BullsEye
//
//  Created by Tony Contreras on 2/10/19.
//  Copyright © 2019 Orbit Networks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

// TODO: app has bug where it starts up with a value of 0, but it should appear as 50. this happens when the user taps on hit me without moving the slider first
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startNewRound()
    }

    @IBAction func showAlert() {
        let message  = "The value of the slider is \(currentValue)" +
        "\nThe target value is \(targetValue)"
        
        let alert = UIAlertController(title: "Hello world!", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        startNewRound()
    
    }
   
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
   
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
    }
   
}

