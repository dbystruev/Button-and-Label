//
//  AppDelegate.swift
//  Button and Label
//
//  Created by Denis Bystruev on 17/01/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

@UIApplicationMain
class Main: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = UIWindow()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window!.rootViewController = ViewController()
        window!.makeKeyAndVisible()
        
        return true
    }
}

class ViewController: UIViewController {
    var count = 0 {
        didSet {
            label.text = "\(count)"
        }
    }

    var label: UILabel!
    var button: UIButton!
    
    override func viewDidLoad() {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.textAlignment = .center
        label.text = "\(count)"
        label.textColor = .yellow
        view.addSubview(label)
        
        button = UIButton(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.setTitle("Нажми", for: .normal)
        view.addSubview(button)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI(size: size, doNotCount: true)
    }
    
    @objc func buttonPressed() {
        updateUI(size: view.frame.size)
    }
    
    func updateUI(size: CGSize, doNotCount: Bool = false) {
        print(#function, size, doNotCount, Date())
        
        let width = size.width
        guard 100 < width else { return }
        
        let height = size.height
        guard 100 < height else { return }

        func randomOrigin() -> CGPoint {
            let x = CGFloat.random(in: 0...width - 100)
            let y = CGFloat.random(in: 0...height - 100)
            
            return CGPoint(x: x, y: y)
        }
        
        var loopCounter = 1_000_000_000
        
        repeat {
            button.frame.origin = randomOrigin()
            label.frame.origin = randomOrigin()
            
            loopCounter -= 1
            
        } while button.frame.intersects(label.frame) && 0 < loopCounter
        
        if !doNotCount {
            count += 1
        }
    }
}
