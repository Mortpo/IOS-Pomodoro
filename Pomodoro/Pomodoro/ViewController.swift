//
//  ViewController.swift
//  Pomodoro
//
//  Created by Romain Anquetin on 12/01/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //les varaiables
    @IBOutlet weak var pomodoroStatus: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var pomodoriBar: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var todoTask: UITextField!
    @IBOutlet weak var pomodoriProgressBar: UIProgressView!
    @IBOutlet weak var colormodestate: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
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
    var playerBigPause:AVAudioPlayer?
    
    //fonction de gestion du temps
    @objc func updateTimer(){
        if actualTime>0 {
            //Timer fonctionne
            actualTime -= 1
            let minutes = actualTime/60
            let secondes = actualTime % 60
            progress = Float(actualTime)
            timerLabel.text = String(format: "%02d:%02d",minutes,secondes)
            pomodoriProgressBar.setProgress((maxpomodoriTime-progress) * (facteur), animated:true)



                
            
        }else{
            //une etape est passe il faut changer l'etat de l'application
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
                if playerBigPause   != nil {
                    playerBigPause!.play()
                }
            default:
                pomodori = 0
            }
            let minutes = actualTime/60
            let secondes = actualTime % 60
            timerLabel.text = String(format: "%02d:%02d",minutes,secondes)
            
        }
        
    }
    // Debute le compteur/le reprend si il ete en pause
    @IBAction func startButonPressed(_ sender: UIButton) {
        if startButton.tintColor == UIColor.systemPurple{
            
            startButton.tintColor = UIColor.systemIndigo
            startButton.setTitle("Stop", for: .normal)


            timer = Timer.scheduledTimer(timeInterval: 1, target: self,selector: #selector(updateTimer),userInfo: nil, repeats: true)
            timer.fire()
        }
        else
        {
            startButton.tintColor = UIColor.systemPurple
            startButton.setTitle("Start", for: .normal)
            timer.invalidate()

            
        }
    }
    
    //si swipe a droite alors on passe au pomodori suivant
    @IBAction func switchToNextPomodori(_ sender: UISwipeGestureRecognizer) {
        actualTime = -1
        updateTimer()
        startButton.tintColor = UIColor.systemPurple
        startButton.setTitle("Start", for: .normal)
        timer.invalidate()
    }
    


    
//Ferme le clavier
    @IBAction func closeKeyBoard(_ sender: UITextField) {
        textField.resignFirstResponder()
    }
    
    

    
    //Changement de couleur theme nuit ou jour
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
    
    
// fonction de reset si le bouton principal est maintenu
    @IBAction func longpressforreset(_ sender: Any) {
        actualTime = 0
        isRunning = false
        progress = 0
        facteur = 0.0
        maxpomodoriTime = 0.0
        pomodori = -1
        startButton.setTitle("Start", for: .normal)
        timer.invalidate()
        startButton.tintColor = UIColor.systemPurple
        timerLabel.text = String(format: "%02d:%02d",0,0)
        pomodoriBar.text = "I I I I"
        pomodoriProgressBar.setProgress(0.5, animated: false)
        pomodoroStatus.text="Pomodoro Tracker"
    }
    
    // MARK: INITALISATION DE VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //verification du theme par defaut de l'appareil
        if overrideUserInterfaceStyle == .light {
            colormodestate.image = UIImage(systemName:"sun.max.fill")
        }
        if overrideUserInterfaceStyle == .dark{
            colormodestate.image = UIImage(systemName:"moon.fill")
        }
        
        
        //generation des player de sons
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
        
        let pathBigPause = Bundle.main.path(forResource: "Rise03", ofType: "aif")
        let urlBigPause =  URL(fileURLWithPath: pathBigPause!)
        
        do{
            playerBigPause = try? AVAudioPlayer(contentsOf: urlBigPause)
        }
        catch{
            print("Can't load sound")
        }
        
        
        // Do any additional setup after loading the view.
    }


}

