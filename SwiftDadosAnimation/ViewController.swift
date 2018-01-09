//
//  ViewController.swift
//  SwiftDadosAnimation
//
//  Created by alberto on 19/12/2017.
//  Copyright © 2017 alberto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var dices : [UIImageView]!
    private var numbers = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setListeners()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setListeners(){
        for dice in dices {
            dice.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self.dices[0], action: #selector(diceTapped(tap:)))
            dice.addGestureRecognizer(tap)
        }
    }
    
    @objc func diceTapped(tap : UITapGestureRecognizer){
        let dice = tap.view as! UIImageView
        let cara = dice.tag
        dice.image = UIImage(named : "cara\(cara)v")
    }
    
    @IBAction func spinDice(_ sender: UIButton) {
        loadAni()
        for dice in self.dices {
            dice.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                dice.stopAnimating()
                self.stopDice(dice : dice)
            })
        }
    }
    
    private func stopDice(dice : UIImageView){
        let random = Int(arc4random_uniform(6))
        dice.image = UIImage(named : "cara\(random)")
        dice.tag = random
    }
    
    private func loadAni(){
        for dice in self.dices {
            dice.animationImages = [UIImage]()
            var counter = 0
            while (counter<6){
                counter+=1
                var random = Int(arc4random_uniform(6))
                while repeated(i : random){
                    random = Int(arc4random_uniform(6))
                }
                numbers.append(random)
                dice.animationImages?.append(UIImage(named: "cara\(random)")!)
            }
            numbers.removeAll()
            dice.animationDuration = 1
        }
    }
    
    private func repeated(i : Int) -> Bool{
        for number in self.numbers {
            if number == i {
                return true
            }
        }
        return false
    }
    
}

