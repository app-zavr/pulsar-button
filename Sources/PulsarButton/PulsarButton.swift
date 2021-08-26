import Foundation

#if canImport(UIKit)
import UIKit
#endif

#if canImport(QuartzCore)
import QuartzCore
#endif




public class PulsarButton: UIButton {
    private var pulseArray = [CAShapeLayer]()
    
    public var duration: TimeInterval = 2.3
    public var scaleFactor: CGFloat = 1.5
    public var lineWidth: CGFloat = 1.0
    public var strokeColor: UIColor = UIColor.darkGray
    public var startOpacity: CGFloat = 0.9
    public var timingFunctionName: CAMediaTimingFunctionName = .easeOut
    
    func setupPulsarLayers() {
        layoutSubviews()
        layoutIfNeeded()
        
        for _ in 0..<2 {
            let circularPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: layer.cornerRadius)
            let pulsatingLayer = CAShapeLayer()
            pulsatingLayer.path = circularPath.cgPath
            pulsatingLayer.lineWidth = lineWidth
            pulsatingLayer.fillColor = UIColor.clear.cgColor
            pulsatingLayer.lineCap = .round
            layer.addSublayer(pulsatingLayer)
            pulseArray.append(pulsatingLayer)
        }
        
        let firstDelay = duration / 10
 
        DispatchQueue.main.asyncAfter(deadline: .now() + firstDelay, execute: {
            self.animatePulsatingLayer(for: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + firstDelay * 1.8, execute: {
                self.animatePulsatingLayer(for: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + firstDelay * 2.2, execute: {
                    self.animatePulsatingLayer(for: 2)
                })
            })
        })
    }
    
    func animatePulsatingLayer(for index:Int) {
        guard index < pulseArray.count else { return }
        
        pulseArray[index].strokeColor = strokeColor.cgColor
        
        let scaleFactor: CGFloat = scaleFactor
        let offsetX = bounds.width / 4
        let offsetY = bounds.height / 4
        let newRect = CGRect(x: self.bounds.origin.x - offsetX, y: self.bounds.origin.y - offsetY, width: self.bounds.width * scaleFactor, height: self.bounds.height * scaleFactor)
        let newPath = UIBezierPath(roundedRect: newRect, cornerRadius: self.bounds.height).cgPath
        
        let frameAnimation = CABasicAnimation(keyPath: "path")
        frameAnimation.toValue = newPath
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.fromValue = startOpacity
        opacityAnimation.toValue = 0.0
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [frameAnimation, opacityAnimation]
        groupAnimation.duration = duration
        groupAnimation.fillMode = .forwards
        groupAnimation.repeatCount = .greatestFiniteMagnitude
        groupAnimation.timingFunction = CAMediaTimingFunction(name: timingFunctionName)
        
        pulseArray[index].add(groupAnimation, forKey: "animation")
    }
}