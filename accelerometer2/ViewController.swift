//
//  ViewController.swift
//  accelerometer2
//
//  Created by Gee C on 1/16/20.
//  Copyright © 2020 Gee C. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getAccelerometerData(timer: Timer){
        // Get the accelerometer data.
        if let data = self.motion.accelerometerData {/*
        if self.lastReading == nil {
            self.lastReading = data
            return
        }*/
            guard let lastReading = self.lastReading else {
                self.lastReading = data
                return
            }
            let dx = lastReading.acceleration.x - data.acceleration.x
            let dy = lastReading.acceleration.x - data.acceleration.y
            let dz = lastReading.acceleration.x - data.acceleration.z
            print("dx: \(dx)\tdy: \(dy)\tdz:\(dz)");
        }
    }
    let motion = CMMotionManager()
    // i.e. 60Hz
    let timerInterval:TimeInterval = 1.0 / 60.0
    var timer: Timer?
    var lastReading: CMAccelerometerData?
    
    @IBAction
    func startAccelerometers(_ sender: UIButton) {
       // testing for the accelerometer hardware availability
       if self.motion.isAccelerometerAvailable {
        self.motion.accelerometerUpdateInterval = self.timerInterval
          self.motion.startAccelerometerUpdates()

          // configuring a timer to fetch the data
          self.timer = Timer(
            fire: Date(),
            interval: self.timerInterval,
            repeats: true, block: self.getAccelerometerData)

        // adding the timer to the current run loop
        RunLoop.current.add(self.timer!, forMode: .default)
       }
    }
    
    @IBAction
    func stopAccelerometer(_ sender: UIButton){
        timer?.invalidate();
    }

}

