//
//  stopClock.swift
//  MindAndBody
//
//  Created by Luke Smith on 09.05.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class StopClock {
    static var shared = StopClock()
    private init() {}
    //
    // View that contains everything
    var stopClockBackgroundView = UIButton()
    // View that contains stopclockView, start button, and cancel button
    var stopClock = UIView()
    var stopClockView = UIView()
    var stopClockLabel = UILabel()
        var timerValue = Int()
        var timerShapeLayer: CAShapeLayer!
        var animationAdded = false
        //
        // Timer
        var didSetEndTime = false
        var startTime = Double()
        var endTime = Double()
        //
        var length = Int()
    
    var isPresented = false

    var startClockButton = UIButton()
    var cancelClockButton = UIButton()
    
    var startButton = UIButton()
    var cancelButton = UIButton()
    
    func setupStopClock(time: Int) {
        length = time
        
        // Reset views
        stopClockBackgroundView.subviews.forEach { $0.removeFromSuperview() }
        stopClock.subviews.forEach { $0.removeFromSuperview() }
        //
        stopClockBackgroundView.frame = UIScreen.main.bounds
        stopClockBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        stopClockBackgroundView.addTarget(self, action: #selector(animateStopClockDown), for: .touchUpInside)
        //
        cancelButton.backgroundColor = Colors.light
        cancelButton.setTitleColor(Colors.red, for: .normal)
        cancelButton.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        cancelButton.frame = CGRect(x: 0, y: stopClock.bounds.height - 10, width: stopClock.bounds.width, height: 49)
        cancelButton.layer.cornerRadius = cancelButton.bounds.height / 2
        cancelButton.clipsToBounds = true
        cancelButton.addTarget(self, action: #selector(animateStopClockDown), for: .touchUpInside)
        stopClock.addSubview(cancelButton)
        stopClockBackgroundView.addSubview(stopClock)
        //
        startButton.backgroundColor = Colors.light
        startButton.setTitleColor(Colors.green, for: .normal)
        startButton.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
        startButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        startButton.frame = CGRect(x: 0, y: stopClock.bounds.height - 40, width: stopClock.bounds.width, height: 49)
        startButton.layer.cornerRadius = startButton.bounds.height / 2
        startButton.clipsToBounds = true
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        stopClock.addSubview(startButton)
        //
        stopClockView.backgroundColor = Colors.dark
        stopClockView.layer.borderWidth = 1
        stopClockView.layer.borderColor = Colors.light.cgColor
        stopClockView.frame = CGRect(x: 0, y: 0, width: stopClock.bounds.width, height: stopClock.bounds.width)
        stopClockView.layer.cornerRadius = 15
        stopClockView.clipsToBounds = true
        stopClock.addSubview(stopClockView)
        //
        stopClockLabel.center = stopClockView.center
        stopClockLabel.font = UIFont(name: "SFUIDisplay-thin", size: 72)
        stopClockLabel.textColor = Colors.light
        stopClockLabel.text = "00:00"
        stopClockLabel.text = timeFormatted(totalSeconds: time)
        stopClockLabel.sizeToFit()
//        stopClockLabel.frame.size = CGSize(width: stopClockView.frame.width, height: stopClockLabel.bounds.height)
        stopClockLabel.textAlignment = .center
        stopClockLabel.backgroundColor = Colors.dark
        stopClockView.addSubview(stopClockLabel)
        

        //
        stopClock.frame.size = CGSize(width: UIScreen.main.bounds.width - 20, height: (UIScreen.main.bounds.width - 20) + 20 + (2*49))
    }
    
    @objc func startButtonAction() {
        // If not timing, begin
        if !didSetEndTime {
            //
            startTimer()
            //
            // Notification
            let content = UNMutableNotificationContent()
            content.title = NSLocalizedString("setOver", comment: "")
            content.sound = UNNotificationSound.default()
            //
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(length), repeats: false)
            let request = UNNotificationRequest(identifier: "stopClock", content: content, trigger: trigger)
            //
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    @objc func startTimer() {
        //
        if isPresented {
            if timerCountDown.isValid {
                timerCountDown.invalidate()
            }
            //
            NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
            //
            startTime = Date().timeIntervalSinceReferenceDate
            //
            if didSetEndTime == false {
                if false {
                    //didEnterBackground {
                    //endTime = startTime + Double(timerValue) - length
                } else {
                    endTime = startTime + Double(length)
                }
                //
                didSetEndTime = true
            }
            //
            if endTime > startTime {
                timerValue = Int(endTime - startTime)
            } else {
                timerValue = 0
                animateStopClockDown()
            }
            
            //
            if timerValue != 0 {
                //
                stopClockLabel.text = timeFormatted(totalSeconds: timerValue)
                
                //
                if animationAdded == false {
                    addCircle()
                    startAnimation()
                }
                timerCountDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
                
            }
        }
    }
    
    
    func animatestopClockUp() {
        isPresented = true
        //
        // Initial Conditions
        stopClockBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0)
        stopClock.frame = CGRect(x: 10, y: UIScreen.main.bounds.height, width: stopClock.bounds.width, height: stopClock.bounds.height)
        UIApplication.shared.keyWindow?.addSubview(stopClockBackgroundView)
        UIApplication.shared.keyWindow?.bringSubview(toFront: stopClockBackgroundView)
        //
        // Animate
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: {
            //
            // iPhone X
            if UIScreen.main.nativeBounds.height == 2436 {
                self.stopClock.frame = CGRect(x: 10, y: UIScreen.main.bounds.height - self.stopClock.bounds.height - 10 - TopBarHeights.homeIndicatorHeight, width: self.stopClock.bounds.width, height: self.stopClock.bounds.height)
            } else {
                self.stopClock.frame = CGRect(x: 10, y: UIScreen.main.bounds.height - self.stopClock.bounds.height - 10, width: self.stopClock.bounds.width, height: self.stopClock.bounds.height)
            }
            //
            self.stopClockBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }, completion: nil)
    }
    
    func resetOptionFrames() {
        cancelButton.frame = CGRect(x: 0, y: stopClock.bounds.height - 49, width: stopClock.bounds.width, height: 49)
        cancelButton.layer.cornerRadius = cancelButton.bounds.height / 2
        cancelButton.clipsToBounds = true
        //
        startButton.frame = CGRect(x: 0, y: stopClock.bounds.height - 49 - 10 - 49, width: stopClock.bounds.width, height: 49)
        startButton.layer.cornerRadius = startButton.bounds.height / 2
        startButton.clipsToBounds = true
        //
        stopClockView.frame = CGRect(x: 0, y: 0, width: stopClock.bounds.width, height: stopClock.bounds.width)
        stopClockView.layer.cornerRadius = 15
        stopClockView.clipsToBounds = true
        //
        stopClockLabel.center = stopClockView.center
    }
    
    @objc func animateStopClockDown() {
        //
        isPresented = false
        //
        // Ensure timer cancelled
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["stopClock"])
        didSetEndTime = false
        timerCountDown.invalidate()
        if animationAdded {
            timerShapeLayer.removeAllAnimations()
            timerShapeLayer.removeFromSuperlayer()
            animationAdded = false
        }
        //
        // Animate
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            //
            self.stopClock.frame = CGRect(x: 10, y: UIScreen.main.bounds.height, width: self.stopClock.bounds.width, height: self.stopClock.bounds.height)
            self.stopClockBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0)
            //
        }, completion: { finished in
            //
            self.stopClockBackgroundView.removeFromSuperview()
        })
        
        //
        // To cancel meditation bell table sounds
        if BellPlayer.shared.bellPlayer != nil {
            if (BellPlayer.shared.bellPlayer?.isPlaying)! {
                BellPlayer.shared.bellPlayer?.stop()
            }
        }
    }
    
    //
    // MARK: Timer Functions
    // Funcs
    func addCircle() {
        //
        let center = stopClockView.center
        let radius = ((stopClockView.frame.size.width - 50) / 2)
        //}
        //
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: .pi * 1.5, endAngle: (.pi * 2) + (.pi * 1.5), clockwise: true)
        //
        timerShapeLayer = CAShapeLayer()
        timerShapeLayer.path = circlePath.cgPath
        timerShapeLayer.fillColor = UIColor.clear.cgColor
        timerShapeLayer.strokeColor = Colors.light.cgColor
        timerShapeLayer.lineWidth = 2.0
        //
        timerShapeLayer.strokeEnd = 0.0
        
        stopClockView.layer.addSublayer(timerShapeLayer)
    }
    
    //
    func removeCircle() {
        timerShapeLayer.removeFromSuperlayer()
    }
    
    //
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = Double(timerValue)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        timerShapeLayer.strokeEnd = 1.0
        //
        timerShapeLayer.add(animation, forKey: "circleAnimation")
        animationAdded = true
        
    }
    
    //
    // MARK: Timer
    // Timer CountDown Title
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Update Timer
    @objc func updateTimer() {
        //
        if timerValue == 0 {
            // Cancelling timer handeled in animatesstopClockDown
            animateStopClockDown()
            //
        } else if timerValue == 1 {
            timerValue -= 1
            stopClockLabel.text = timeFormatted(totalSeconds: timerValue)
            stopClockLabel.sizeToFit()
            //
        } else {
            timerValue -= 1
            stopClockLabel.text = timeFormatted(totalSeconds: timerValue)
            stopClockLabel.sizeToFit()
        }
    }
    
    // Cancel tasks
    func cancelTasks() {
        // Cancel Dispatch of next actions (and thus vibrations)
//        if task2 != nil {
//            task2?.cancel()
//        }
//        if task1 != nil {
//            task1?.cancel()
//        }
    }
}
