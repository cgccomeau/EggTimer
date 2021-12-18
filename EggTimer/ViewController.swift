//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft": 3.0, "Medium": 5.0, "Hard": 10.0]
    var timer = Timer()
    var timeLeft = 1.0
    var timeTotal = 1.0
    
    override func viewDidLoad() {
        self.progressBar.progress = 0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        self.titleView.text = "How do you like your eggs?"
        timer.invalidate()
        let hardness = sender.currentTitle
        timeLeft = eggTimes[hardness!]!
        timeTotal = timeLeft
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { timer in
            self.progressBar.progress = 1 - Float(self.timeLeft) / Float(self.timeTotal)
            if self.timeLeft < 0 {
                timer.invalidate()
                self.titleView.text = "Done"
                self.playSound()
            }
            self.timeLeft -= timer.timeInterval
        }
    }
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
