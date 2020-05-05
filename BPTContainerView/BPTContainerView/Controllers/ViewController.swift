//
//  ViewController.swift
//  BPTContainerView
//
//  Created by Basith on 20/02/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var overlayView: UIView!
    var childviewcontroller : UIViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "childVC") as? ChildViewController)!
    
    var containerView = UIView()
    
    @IBAction func buttonClicked(_ sender: Any) {
        addContainerView(view : containerView, xPos: Double(self.view.bounds.width * 0.05), yPos: Double(self.view.bounds.height/3), width: Double(self.view.bounds.width * 0.9), height: Double(self.view.bounds.height/3))
        changeViewController(toVC: childviewcontroller)
        overlayView.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.isHidden = true
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.changeBackground (_:)))
        self.overlayView.addGestureRecognizer(gesture)
    }
    @objc func changeBackground(_ sender:UITapGestureRecognizer){
        self.overlayView.isHidden = true
        self.containerView.removeFromSuperview()
//        self.view.endEditing(true)
    }


}
extension ViewController: ContainerVCDelegate{
    func addContainerView(view: UIView, xPos: Double, yPos: Double, width: Double, height: Double) {
            view.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        }
        
        func addConstraintsToContainerView() {
            print("")
        }
         
        func changeViewController(toVC: UIViewController) {
            childviewcontroller = toVC
            childviewcontroller.view.frame = containerView.bounds
            addChild(childviewcontroller)
            containerView.addSubview(childviewcontroller.view)
            childviewcontroller.didMove(toParent: self)
            self.view.addSubview(containerView)
        }
        
        func addContainerView(containerFrame: CGRect){
            containerView.frame = containerFrame
        }
        
        func changeViewController(toVC : UIViewController, toView: UIView, theView : UIView) {
            childviewcontroller.view.removeFromSuperview()
            childviewcontroller.removeFromParent()
            childviewcontroller = toVC
            childviewcontroller.view.frame = toView.bounds
            addChild(childviewcontroller)
            toView.addSubview(childviewcontroller.view)
            childviewcontroller.didMove(toParent: self)
        }
}

public protocol ContainerVCDelegate {
    func addContainerView(containerFrame: CGRect)
    func addContainerView(view: UIView, xPos: Double, yPos: Double, width: Double, height: Double)
    func addConstraintsToContainerView()
    func changeViewController(toVC : UIViewController, toView: UIView, theView : UIView)
    func changeViewController(toVC : UIViewController)
}

