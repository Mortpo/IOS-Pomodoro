//
//  ViewController.swift
//  Pomodoro
//
//  Created by Romain Anquetin on 12/01/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var pomodoroStatus: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var pomodoriBar: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var todoTask: UITextField!
    @IBOutlet weak var pomodoriProgressBar: UIProgressView!
    
    let maxPomodori = 4
    var pomodori = -1
    var timer = Timer()
    let pauseTime = 5*60
    let pomodoriTime = 25*60
    let longPauseTime = 20*60
    var actualTime = 0
    var isRunning = false
    var progress:Float = 0
    var facteur:Float = 0.0
    var maxpomodoriTime:Float = 0.0
    var playerPomodori:AVAudioPlayer?
    var playerPause:AVAudioPlayer?
    
    @objc func updateTimer(){
        if actualTime>0 {
            actualTime -= 1
            let minutes = actualTime/60
            let secondes = actualTime % 60
            progress = Float(actualTime)
            timerLabel.text = String(format: "%02d:%02d",minutes,secondes)
            pomodoriProgressBar.setProgress((maxpomodoriTime-progress) * (facteur), animated:true)



                
            
        }else{
            pomodori = (pomodori + 1) % 8
            pomodoriProgressBar.setProgress(0, animated: true)
            switch pomodori {
            case 0:
                actualTime=pomodoriTime
                pomodoriBar.text = "I"
                pomodoriBar.textColor = UIColor.systemGreen
                facteur = 1.0 / Float(pomodoriTime)
                maxpomodoriTime = Float(pomodoriTime)
                pomodoroStatus.text="Working Time"
                if playerPomodori != nil {
                    playerPomodori!.play()
                }
                
            case 1:
                actualTime=pauseTime
                pomodoriBar.textColor = UIColor.darkGray
                facteur = 1.0 / Float(pauseTime)
                maxpomodoriTime = Float(pauseTime)
                pomodoroStatus.text="Pause Time"
                if playerPause   != nil {
                    playerPause!.play()
                }
                
            case 2:
                actualTime=pomodoriTime
                pomodoriBar.text = "I I"
                pomodoriBar.textColor = UIColor.systemGreen
                facteur = 1.0 / Float(pomodoriTime)
                maxpomodoriTime = Float(pomodoriTime)
                pomodoroStatus.text="Working Time"
                if playerPomodori != nil {
                    playerPomodori!.play()
                }
            case 3:
                actualTime=pauseTime
                pomodoriBar.textColor = UIColor.darkGray
                facteur = 1.0 / Float(pauseTime)
                maxpomodoriTime = Float(pauseTime)
                pomodoroStatus.text="Pause Time"
                if playerPause   != nil {
                    playerPause!.play()
                }
            case 4:
                actualTime=pomodoriTime
                pomodoriBar.text = "I I I"
                pomodoriBar.textColor = UIColor.systemGreen
                facteur = 1.0 / Float(pomodoriTime)
                maxpomodoriTime = Float(pomodoriTime)
                pomodoroStatus.text="Working Time"
                if playerPomodori != nil {
                    playerPomodori!.play()
                }
            case 5:
                actualTime=pauseTime
                pomodoriBar.textColor = UIColor.darkGray
                facteur = 1.0 / Float(pauseTime)
                maxpomodoriTime = Float(pauseTime)
                pomodoroStatus.text="Pause Time"
                if playerPause   != nil {
                    playerPause!.play()
                }
            case 6:
                actualTime=pomodoriTime
                pomodoriBar.text = "I I I I"
                pomodoriBar.textColor = UIColor.systemGreen
                facteur = 1.0 / Float(pomodoriTime)
                maxpomodoriTime = Float(pomodoriTime)
                pomodoroStatus.text="Working Time"
                if playerPomodori != nil {
                    playerPomodori!.play()
                }
            case 7:
                actualTime=longPauseTime
                pomodoriBar.textColor = UIColor.darkGray
                facteur = 1.0 / Float(longPauseTime)
                maxpomodoriTime = Float(longPauseTime)
                pomodoroStatus.text="Pause Time"
                if playerPause   != nil {
                    playerPause!.play()
                }
            default:
                pomodori = 0
            }
            let minutes = actualTime/60
            let secondes = actualTime % 60
            timerLabel.text = String(format: "%02d:%02d",minutes,secondes)
            
        }
        
    }
    
    @IBAction func startButonPressed(_ sender: UIButton) {
        if startButton.tintColor == UIColor.systemPurple{
            
            startButton.tintColor = UIColor.systemIndigo
            buttonLabel.text = "Stop"


            timer = Timer.scheduledTimer(timeInterval: 1, target: self,selector: #selector(updateTimer),userInfo: nil, repeats: true)
            timer.fire()
        }
        else
        {
            startButton.tintColor = UIColor.systemPurple
            buttonLabel.text = "Start"
            timer.invalidate()

            
        }
    }
    
    @IBOutlet weak var colormodestate: UIImageView!
    @IBAction func switchMode(_ sender: UISwitch) {
        if overrideUserInterfaceStyle == .dark {
            overrideUserInterfaceStyle = .light
            colormodestate.image = UIImage(systemName:"sun.max.fill")
            //colormodestate.tintColor=UIColor
        }
        else{
            overrideUserInterfaceStyle = .dark
            colormodestate.image = UIImage(systemName:"moon.fill")
        }
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let pathPomodori = Bundle.main.path(forResource: "Coin01", ofType: "aif")
        let urlPomodori =  URL(fileURLWithPath: pathPomodori!)
        
        do{
            playerPomodori = try? AVAudioPlayer(contentsOf: urlPomodori)
        }
        catch{
            print("Can't load sound")
        }
        
        let pathPause = Bundle.main.path(forResource: "Rise06", ofType: "aif")
        let urlPause =  URL(fileURLWithPath: pathPause!)
        
        do{
            playerPause = try? AVAudioPlayer(contentsOf: urlPause)
        }
        catch{
            print("Can't load sound")
        }
        
        
        
        // Do any additional setup after loading the view.
    }


}

