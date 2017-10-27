//
//  ViewController.swift
//  APP 5
//
//  Created by ZAC BROOKS on 11/13/16.
//  Copyright © 2016 com.student.alliance All rights reserved.
//

import UIKit
import Foundation
import GameKit
import SpriteKit
import GLKit
import AVFoundation
class TargetGame: UIViewController {

    var player : AVAudioPlayer?
    var targetx = Array(repeating: Int(arc4random() % UInt32(40)), count: 15)
    var norepeat : Bool = true
    var height : Double!
    var width : Double!
    var originX : Double!
    var originY : Double!
    var touchX : Double = 0
    var touchY : Double = 0
    var start : NSDate?
    var end: NSDate?
    var angle : CGFloat = 0
    
    var physicstimer : Timer!
    var myCounter : CGFloat = 0
    var upSwipe = UIPanGestureRecognizer()
    let activeTarget = UIImage(named: "touched.png")
    let inactiveTarget = UIImage(named: "untouched.png")
    let cannonBall = UIImage(named: "fireball_by_wyonet-d5zowv7.png")
    let sky = UIImage(named: "MAL3oZ.jpg")
    let aliencannon = UIImage(named: "aliensprite.png")
    let spaceship = UIImage(named: "10a3e1ef29ca4ec02db2ec6bb32ff18f.png")
    let horde1 = UIImage(named: "yJS9nQV.png")
    var projectile : UIButton!
    var target = Array(repeating: UIImageView(), count: 15)
    var touchLayer : UIView!
    var numberOfTargets : Int!
    
    var cannon_x : CGFloat!
    var cannon_y : CGFloat!
    
    var initialX : CGFloat!
    var initialY : CGFloat!
    

    private var timer : Timer!
    var x : Double!
   
    var fireable : Bool = false
    var velocity : Double = 0
    var starttouchtime : Double = 0
    var endtouchtime : Double = 0
    var starttouchpoint : CGPoint?
    var endtouchpoint : CGPoint?
    var bloodsplatter1 = UIImage(named: "bloodsplatter1.png")
    var bloodsplatter2 = UIImage(named: "bloodsplatter2.png")
    var bloodsplatter3 = UIImage(named: "bloodsplatter3.png")
    var alien2 = UIImage(named: "Alien_Scout.png")
    var alien3 = UIImage(named: "BatEye-ffx")
    
    var url = Bundle.main.url(forResource: "targethit", withExtension: "wav")!
    var score : Int = 0
    var shots : Int = 0
    @IBOutlet var scorekeep : UILabel!
    @IBOutlet var  shotkeep : UILabel!
    @IBOutlet var  health : UILabel!
    @IBOutlet var  healthbar : UILabel!
    
     var images = [UIImage]()
    var targettype = Array( repeating: Int(), count: 15)
    
    var gametimer : Timer!
    var targetpoints = Array(repeating: CGPoint(), count: 15)
    var targetcounter = 500
    var flipswitch = Array(repeating: Int(1), count: 15)
    override func viewDidLoad() {
        
        super.viewDidLoad()
         
        self.images = [bloodsplatter1!, bloodsplatter2!, bloodsplatter3!]

        let cSelector : Selector = "touchEvent:"
        self.upSwipe = UIPanGestureRecognizer(target: self, action: cSelector)
        self.view.addGestureRecognizer(self.upSwipe)
        
        numberOfTargets = target.count
        setup()
        drawTargets()
        
        self.gametimer = Timer.scheduledTimer(timeInterval: 0.10, target: self, selector: #selector(TargetGame.moveTargets), userInfo: self, repeats: true)

        do {
            player = try AVAudioPlayer(contentsOf: self.url)
            
            
            player!.prepareToPlay()
            
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
    func drawTargets(){
        
        var i = 0
        
        
        while(i<numberOfTargets){
            self.targettype[i] = Int(arc4random() % UInt32(3))
            
            let randomX = Int(arc4random()%UInt32(width - 0.1 * width) + 1)
            
            var randomY = Int(arc4random()%UInt32(height - 0.40 * height) + 50)

          targetpoints[i] = CGPoint(x: randomX, y: randomY)
            
          
            
            if(targettype[i] == 0 )
            {
                 target[i] = UIImageView(frame: CGRect(CGFloat(randomX), CGFloat(randomY), CGFloat(width * 0.17), CGFloat(0.17 * width)))
            target[i].image = horde1
            }
            if(targettype[i] == 1 )
            {
                 target[i] = UIImageView(frame: CGRect(CGFloat(randomX), CGFloat(randomY), CGFloat(width * 0.25), CGFloat(0.25 * width)))
                target[i].image = alien2
            }
            if(targettype[i] == 2 )
            {
                 target[i] = UIImageView(frame: CGRect(CGFloat(randomX), CGFloat(randomY), CGFloat(width * 0.10), CGFloat(0.10 * width)))
                target[i].image = alien3
            }
            
            self.view.addSubview(target[i])
            i+=1
        }

    }
    
    func setup(){
        
        height = Double(self.view.frame.size.height)
        width = Double(self.view.frame.size.width)
        originX = width/2
        originY = height/2
        
        touchLayer = UIView(frame: CGRect(0, 0, CGFloat(width), CGFloat(height)))
         touchLayer.addGestureRecognizer(upSwipe)
        
        let background = UIImageView(frame: CGRect(0, 0, CGFloat(width), CGFloat(height)))
        let foreground = UIImageView(frame: CGRect(0, CGFloat(0.80 * height), CGFloat(width), CGFloat(0.20 * height)))
       // let cannon = UIView(frame: CGRectMake(CGFloat(originX - (0.05 * width)), CGFloat(0.875 * height), CGFloat(width * 0.15), CGFloat(0.125 * height)))
        let aliencannoning = UIImageView(frame: CGRect(CGFloat(originX - (0.05 * width)), CGFloat(0.875 * height), CGFloat(width * 0.1), CGFloat(0.075 * height)))
        aliencannoning.image = aliencannon
        
        projectile = UIButton(frame: CGRect(CGFloat(originX - (0.05 * width)), CGFloat((0.875 * height) - (width * 0.1)), CGFloat(width * 0.15), CGFloat(0.15 * width)))
        
        background.image = sky
        foreground.image = spaceship
        //cannon.backgroundColor = UIColor.init(red: 0.8, green: 0.45, blue: 0.25, alpha: 1)
        projectile.setImage(cannonBall, for: .normal)
        initialX = self.projectile.frame.origin.x
        initialY = self.projectile.frame.origin.y

        cannon_x = self.projectile.frame.origin.x
        cannon_y = self.projectile.frame.origin.y
       // projectile.addTarget(self, action: #selector(fire), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.view.addSubview(background)
        self.view.addSubview(foreground)
       // self.view.addSubview(cannon)
        self.view.addSubview(aliencannoning)
        self.view.addSubview(projectile)
       self.view.addSubview(touchLayer)
        self.view.addSubview(shotkeep)
        self.view.addSubview(scorekeep)
        self.view.addSubview(health)
        self.view.addSubview(healthbar)
    }
    func playSound() {
        
        
        
      player!.play()  }
    func moveTargets(){
        var z = 0
       
        self.targetcounter -= 1
        
        
        print(self.targetcounter)
        while (z < target.count)
        {
       
     
            if (Double(self.targetpoints[z].x) < 0.0)
            {
            flipswitch[z] = 1
            }
            
            else if (Double(self.targetpoints[z].x)  > self.width)
            {
            flipswitch[z] = -1
            }

            
           
              self.targetpoints[z].x += CGFloat(10*flipswitch[z])
            
            
            
            if(targettype[z] == 0 )
            {
                var ex = self.targetx[z]
                var eq3 = "15 * sin(" + String(ex) + ")"
                var newy = CGFloat(GCMathParser.evaluate(eq3))

                self.target[z] .frame = CGRect( x: self.targetpoints[z].x , y: (self.targetpoints[z].y + newy), width:  CGFloat(width * 0.17), height: CGFloat(0.17 * width))
                self.target[z].setNeedsDisplay()

            }
            if(targettype[z] == 1 )
            {
                var ex = self.targetx[z]
                var eq3 = "25 *  cos(" + String(ex) + ")"
                var newy = CGFloat(GCMathParser.evaluate(eq3))

                self.target[z] .frame = CGRect( x: self.targetpoints[z].x , y: (self.targetpoints[z].y + newy), width:  CGFloat(width * 0.25), height: CGFloat(0.25 * width))
                self.target[z].setNeedsDisplay()

            }
            if(targettype[z] == 2 )
            {
                var ex = self.targetx[z]
                var eq3 = "15 * sin(" + String(ex) + ")"
                var newy = CGFloat(GCMathParser.evaluate(eq3))

                self.target[z] .frame = CGRect( x: self.targetpoints[z].x , y: (self.targetpoints[z].y + newy), width:  CGFloat(width * 0.10), height: CGFloat(0.10 * width))
                self.target[z].setNeedsDisplay()

            }

            
          

            self.targetx[z] += 1
            z += 1
        if(self.targetcounter % 20 == 0)
        { var h = 0
          var  healthbarnick = self.targetcounter/20
            var healthbarstring : String = ""
        while ( h < healthbarnick)
        {
            healthbarstring += "|"
            h += 1
            }
            
        self.healthbar.text = healthbarstring
        
        }
        
        if (self.targetcounter <= 0)
        {
            self.gametimer.invalidate()
            let loseController = UIAlertController(title: "uh oh...", message: "our whole race is now extinct", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "let's go again", style: .default, handler: resetItAll)
            //you can add custom actions as well
            loseController.addAction(defaultAction)
            
            present(loseController, animated: true, completion: nil)
        }
    }

    }
    func touchEvent(_ gesture: UIGestureRecognizer){
       
        if(self.norepeat == true)
        {
        
        
        let swipeGesture = gesture as? UIPanGestureRecognizer
            var movepoint : CGPoint?
        
      switch (swipeGesture!.state)
      {
      case UIGestureRecognizerState.began:
        
        self.starttouchpoint = swipeGesture!.location(in: touchLayer)
        self.start = NSDate()

        if (self.projectile.frame.contains(self.starttouchpoint!))
        {
        
        self.fireable = true
                print("began at: ")
       
        }
        
        break
        
      case UIGestureRecognizerState.ended:
        self.endtouchpoint  = swipeGesture!.location(in: touchLayer)
        if (self.fireable == true && self.endtouchpoint!.y < self.starttouchpoint!.y)
        {
        
        self.end = NSDate()
       print("ended at: " )
     
       
        self.computeVelocity()
        
        self.startPhysicsTimer()
        
        print(self.angle)
        print(self.velocity)
        self.fireable = false
        }
        
        break
      case UIGestureRecognizerState.changed:
        movepoint = swipeGesture!.location(in: touchLayer)
        if (self.projectile.frame.contains(movepoint!))
        {
            
            self.fireable = true
        }
        
        default:
        
        break
        
        }
        }
        
    }

func resetItAll (sender: AnyObject)
{
    self.targetcounter = 500
    self.scorekeep.text = "Score: 0"
    self.shotkeep.text = "Shots : 0"
    self.score = 0
    self.shots = 0
    self.viewDidLoad()
   self.viewWillAppear(false)
    
    }


    func startPhysicsTimer(){
        print("physics started")
        self.physicstimer = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(TargetGame.physicsMove), userInfo: self, repeats: true)
        
        
    }
    func computeVelocity()
    {
        //Get the time
        var startTouch = self.start
    
        
        
        //Get the time
        var end_time = self.end
        
        //compute your velocity
        var dist = Double(sqrt(pow(self.starttouchpoint!.x - self.endtouchpoint!.x,2.0)+pow(self.starttouchpoint!.y - self.endtouchpoint!.y,2.0)));
        var delta_t = self.end!.timeIntervalSince(self.start! as Date)
        //print(delta_t)
        //print(dist)
        
        
        self.velocity = (dist * 0.05) / delta_t
        
        //compute angle
        self.angle = atan2 ((starttouchpoint!.y - endtouchpoint!.y) , (endtouchpoint!.x  -     starttouchpoint!.x))
        //self.angle  = CGFloat(GLKMathRadiansToDegrees(Float(self.angle)))
        
        
        
    }
    
  func physicsMove(){
    self.norepeat = false
    self.myCounter = myCounter + (0.025)*10

   
   
    let eq = "(" + String(velocity) + "*(cos(" + String(describing: angle) + ")*" + String(describing: self.myCounter) + "))*1 +" + String(describing: initialX!)
    let eq2 = "(-" + String(velocity) + "*(sin(" + String(describing: angle) + ")*" + String(describing: self.myCounter) + ") + 0.2 * 9.8 * " + String(describing: self.myCounter) + "*" + String(describing: self.myCounter) + ") * 1 +" + String(describing: initialY!)

    
    
    self.cannon_x = CGFloat(GCMathParser.evaluate(eq))
    self.cannon_y = CGFloat(GCMathParser.evaluate(eq2))
    
//            self.cannon_x = CGFloat((CGFloat(-velocity) * simple * PIX_M) + self.initialX)
//              self.cannon_y = (simple2 + simple3)

    
    self.projectile.frame = CGRect(CGFloat(self.cannon_x), CGFloat(self.cannon_y), self.projectile.frame.size.width, self.projectile.frame.size.height)
    
    self.projectile.setNeedsDisplay()
    
var i = 0
while i < target.count {

    if(self.projectile.frame.intersects(target[i].frame)) && (target[i].image != nil){
target[i].image = nil
target[i].animationImages = self.images
target[i].animationDuration = 0.30
target[i].animationRepeatCount = 1
target[i].startAnimating()
playSound()
    self.score+=1
    self.scorekeep.text = "Score: " + String(self.score)
    if(self.score == target.count)
    {
//        var success = "WOW"
//        var message = " YOU PROTECTED THE SHIP FROM THE HORDE!"
//        var cancel = "i want some more"
//        
//        var successdawg = UIAlertView(title: success, message: message, delegate: nil, cancelButtonTitle: cancel)
//        successdawg.show()
// 
        self.gametimer.invalidate()
        let winController = UIAlertController(title: "WOW", message: "YOU PROTECTED THE SHIP FROM THE HORDE!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "i want some more", style: .default, handler: resetItAll)
        //you can add custom actions as well
        winController.addAction(defaultAction)
        
        present(winController, animated: true, completion: nil)
        

    }
}
i+=1
print(i)
}
    
if(self.cannon_x > CGFloat(width) || self.cannon_y > CGFloat(height) || self.cannon_x < 0){

self.projectile.frame = CGRect(CGFloat(originX - (0.05 * width)), CGFloat((0.88 * height - 0.07 * width)), CGFloat(width * 0.15), CGFloat(0.15 * width))
self.norepeat = true
cannon_x = self.projectile.frame.origin.x
cannon_y = self.projectile.frame.origin.y
self.myCounter = 0
self.projectile.setNeedsDisplay()
self.x = 0
self.shots += 1
self.shotkeep.text = "Shots: " + String(self.shots)
physicstimer.invalidate()
    
    for i in 0..<numberOfTargets
    {
        if (target[i].image == inactiveTarget)
        {
            target[i].image = nil
           
        }
   
    print(i)}
    
}
    
    }
    

   
}

extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}
extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}
extension CGPoint{
    init(_ x:CGFloat,_ y:CGFloat) {
        self.init(x:x,y:y)
    }
}
