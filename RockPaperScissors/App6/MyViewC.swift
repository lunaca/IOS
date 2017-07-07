//
//  MyViewC.swift
//  App6
//
//  Created by ZAC BROOKS on 12/1/16.
//  Copyright © 2016 uca. All rights reserved.
//

import UIKit

class MyViewC: UIViewController {

    @IBOutlet var userscorekeep : UILabel!
    @IBOutlet var iphonescorekeep : UILabel!
    @IBOutlet var refereekeep : UILabel!
    
    @IBOutlet var lion : UIImageView!
    @IBOutlet var cobra : UIImageView!
    @IBOutlet var rabbit : UIImageView!
    @IBOutlet var arena : UIImageView!
    @IBOutlet var titlee : UIImageView!
    var height : Double = 0
    var width : Double = 0
    var originX  : Double = 0
    var originY : Double = 0
    var moveSwipe = UIPanGestureRecognizer()
    var touchLayer : UIView!
    var startTouchPoint : CGPoint?
    var endTouchPoint : CGPoint?
    var touchlion : Bool = false;
    var touchcobra : Bool = false;
    var touchrabbit : Bool = false;
    var refereestring : String = ""
    var userscore = 0
    var iphonescore = 0
    var time = UInt32(Date().timeIntervalSinceReferenceDate)
    var lion0 = UIImage(named: "lion0.png")
    var lion1 = UIImage(named: "lion1.png")
    var lion2 = UIImage(named: "lion2.png")
    var lion3 = UIImage(named: "lion3.png")
    
    var images =  [UIImage]()
    var lionorigin : CGPoint?
    var cobraorigin : CGPoint?
    var rabbitorigin : CGPoint?
    var sidelion = UIImage(named: "lion0 copy.png")
    var sidecobra = UIImage(named: "cobra copy.png")
    var siderabbit = UIImage(named: "rabbit copy.png")
    override func viewDidLoad() {
        super.viewDidLoad()

        height = Double(self.view.frame.size.height)
        width = Double(self.view.frame.size.width)
        originX = width/2
        originY = height/2
        let cSelector : Selector = #selector(MyViewC.touchEvent(_:))
        self.moveSwipe = UIPanGestureRecognizer(target: self, action: cSelector)
        self.view.addGestureRecognizer(self.moveSwipe)
        images = [lion0!,lion1!, lion2!, lion3!]

        touchLayer = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
        touchLayer.addGestureRecognizer(moveSwipe)
        
        
        self.view.addSubview(touchLayer)
        self.lionorigin = self.lion.frame.origin
            self.cobraorigin = self.cobra.frame.origin
            self.rabbitorigin = self.rabbit.frame.origin
        titleAnimation()
     
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
func titleAnimation(){

UIView.animate(withDuration: 4, delay: 0, options: [], animations: {
self.titlee.frame = CGRect(x: CGFloat(self.view.frame.width * 0.1), y: 5, width: CGFloat(self.view.frame.width * 0.8), height: CGFloat(self.view.frame.height / 5))
}, completion: {(finished:Bool) in

})
    UIView.animate(withDuration: 2, delay: 4, options: [], animations: {
        self.titlee.alpha = 0
        
        }, completion: {(finished:Bool) in})
    UIView.animate(withDuration: 2, delay: 6, options: [], animations: {
        self.userscorekeep.alpha = 1
        
        }, completion: {(finished:Bool) in})
    UIView.animate(withDuration: 2, delay: 6, options: [], animations: {
        self.iphonescorekeep.alpha = 1
        
        }, completion: {(finished:Bool) in})
   
    }
    
    func lionBattle()
    {
        
   let obiwan =  arc4random_uniform(3) + 1
        let evil = UIImageView(frame: CGRect(x: 30, y: lion.frame.origin.y, width: CGFloat(lion.frame.width), height: CGFloat(lion.frame.height)))
        if (obiwan == 1 )
        {
            
            evil.image = sidelion
            
          self.refereestring = "LION TIES LION! TIE!"
        }
        if (obiwan == 2 )
        {
            
            evil.image = sidecobra
          self.iphonescore+=1
         self.refereestring = "COBRA BEATS LION! LION LOSES"
            
        }

        if (obiwan == 3 )
        {
           
            evil.image = siderabbit
            self.userscore += 1
           self.refereestring = "LION BEATS RABBIT! LION WINS"
        }
        
        
self.view.addSubview(evil)
    
        UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
            evil.alpha = 0
            self.lion.frame = evil.frame
            }, completion: {(finished:Bool) in})
    pointDraw()
        UIView.animate(withDuration: 2,delay: 3,  options: [],  animations: {
            self.lion.frame.origin = self.lionorigin!
            }
            , completion: {(finished:Bool) in
        })

    }
    func pointDraw()
    {
        userscorekeep.text = "User Score: " + String(self.userscore)
        iphonescorekeep.text = "CPU Score: " + String(self.iphonescore)
        
        refereekeep.text = self.refereestring
        print(refereestring)
        UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
            self.refereekeep.alpha = 1
            
            }, completion: {(finished:Bool) in})
        UIView.animate(withDuration: 2, delay: 3, options: [], animations: {
            self.refereekeep.alpha = 0
            
            }, completion: {(finished:Bool) in})

    }
    func cobraBattle()
    {
        
      let obiwan =  arc4random_uniform(3) + 1
        let evil = UIImageView(frame: CGRect(x: 30, y: cobra.frame.origin.y, width: CGFloat(lion.frame.width), height: CGFloat(cobra.frame.height)))
        if (obiwan == 1 )
        {
            
            evil.image = sidelion
            self.userscore += 1
           self.refereestring = " COBRA BEATS LION. COBRA WINS"
        }
        if (obiwan == 2 )
        {
            
            evil.image = sidecobra
            
         self.refereestring = "COBRA TIES COBRA. TIE!"
            
        }
        
        if (obiwan == 3 )
        {
            
            evil.image = siderabbit
            self.iphonescore+=1
         self.refereestring = "RABBIT OUTRUNS COBRA. COBRA LOSES"
            
        }
        
        
        self.view.addSubview(evil)
        
        UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
            evil.alpha = 0
            self.cobra.frame = evil.frame
            }, completion: {(finished:Bool) in})
        pointDraw()
        UIView.animate(withDuration: 2,delay: 3,  options: [],  animations: {
            self.cobra.frame.origin = self.cobraorigin!
            }
            , completion: {(finished:Bool) in
        })
        
        
    }
    
    func rabbitBattle()
    {
     
      let obiwan =  arc4random_uniform(3)
        let evil = UIImageView(frame: CGRect(x: 30, y: rabbit.frame.origin.y, width: CGFloat(rabbit.frame.width), height: CGFloat(rabbit.frame.height)))
        if (obiwan == 0 )
        {
            
            evil.image = sidelion
            
          self.refereestring = "LION CATCHES RABBIT. RABBIT LOSES"
        self.iphonescore += 1
        }
        if (obiwan == 1 )
        {
            
            evil.image = sidecobra
            
           self.refereestring = "RABBIT OUTRUNS COBRA. RABBIT WINS"
            self.userscore += 1
        }
        
        if (obiwan == 2)
        {
            
            evil.image = siderabbit
            
             self.refereestring = "RABBIT TIES RABBIT"
        }
        
        
        self.view.addSubview(evil)
        
        UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
            evil.alpha = 0
            self.rabbit.frame = evil.frame
            }, completion: {(finished:Bool) in})
        pointDraw()
        UIView.animate(withDuration: 2,delay: 3,  options: [],  animations: {
            self.rabbit.frame.origin = self.rabbitorigin!
            }
            , completion: {(finished:Bool) in
        })
        
    }
    
    func touchEvent(_ gesture: UIGestureRecognizer){
      
        let swipeGesture = gesture as? UIPanGestureRecognizer
        var movepoint : CGPoint?
        
        switch (swipeGesture!.state)
        {
        case UIGestureRecognizerState.began:
            
            self.startTouchPoint = swipeGesture!.location(in: touchLayer)
           print(startTouchPoint)
            
            if (self.lion.frame.contains(self.startTouchPoint!))
            {
                
                self.touchlion = true
                self.lion.animationImages = images
                self.lion.animationDuration = 1.0
                self.lion.startAnimating()
               
                
            }
            
            if (self.cobra.frame.contains(self.startTouchPoint!))
            {
                
                self.touchcobra = true
                
               
                
            }

            if (self.rabbit.frame.contains(self.startTouchPoint!))
            {
                
                self.touchrabbit = true
                
                         }

            break
        case UIGestureRecognizerState.changed:
            
            movepoint = swipeGesture!.location(in: touchLayer)
            
                if (self.touchlion)
            {
                lion.frame.origin.x = movepoint!.x - (lion.frame.width/2)
                lion.frame.origin.y = movepoint!.y - (lion.frame.height/2)
                
                
            }
            
            
            if (self.touchcobra)
            {
                cobra.frame.origin.x = movepoint!.x - (cobra.frame.width/2)
                cobra.frame.origin.y = movepoint!.y - (cobra.frame.height/2)
                
                
            }

            
            if (self.touchrabbit)
            {
                rabbit.frame.origin.x = movepoint!.x - (rabbit.frame.width/2)
                rabbit.frame.origin.y = movepoint!.y - (rabbit.frame.height/2)
                
                
            }

        case UIGestureRecognizerState.ended:
            self.endTouchPoint  = swipeGesture!.location(in: touchLayer)
            
            if (self.arena.frame.contains(endTouchPoint!) && self.touchlion)
            {
                self.lion.stopAnimating()
                lionBattle()
            }
            if (self.arena.frame.contains(endTouchPoint!) && self.touchcobra)
            {
                
                cobraBattle()
            }
            
            if (self.arena.frame.contains(endTouchPoint!) && self.touchrabbit)
            {
                
                rabbitBattle()
            }
            
            
            
            
            if (!self.arena.frame.contains(endTouchPoint!) && self.touchlion)
            {
                self.lion.stopAnimating()
                UIView.animate(withDuration: 2,delay: 0,  options: [],  animations: {
                    self.lion.frame.origin = self.lionorigin!
                }
                    , completion: {(finished:Bool) in
                })
          
            }
            
            if (!self.arena.frame.contains(endTouchPoint!) && self.touchcobra)
            {
                UIView.animate(withDuration: 2,delay: 0,  options: [],  animations: {
                    self.cobra.frame.origin = self.cobraorigin!
                    }
                    , completion: {(finished:Bool) in
                })
                
            }

            if (!self.arena.frame.contains(endTouchPoint!) && self.touchrabbit)
            {
                UIView.animate(withDuration: 2,delay: 0,  options: [],  animations: {
                    self.rabbit.frame.origin = self.rabbitorigin!
                    }
                    , completion: {(finished:Bool) in
                })
                
            }

            
            print(endTouchPoint)
            self.touchlion = false
            self.touchcobra = false
            self.touchrabbit = false

    default:
            break
    
    }
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
