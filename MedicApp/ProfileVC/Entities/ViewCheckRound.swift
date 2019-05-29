import UIKit

@IBDesignable
class ViewCheckRound: UIView {
    
    
    @IBInspectable var color: UIColor = #colorLiteral(red: 0.337254902, green: 0.7529411765, blue: 0.9921568627, alpha: 1)
    
    var inPath: IndexPath?
    private func post() {
        print(inPath!)
        NotificationCenter.default.post(name: NSNotification.Name("\(inPath!) changedValue"), object: nil)
    }
    private var firstLoad = true
    @IBInspectable var isActive: Bool = false
    
    private var recognizerAdded = false
    
    
    private var radiusBig: CGFloat {
        let smallSide = min(bounds.height, bounds.width)
        return smallSide / 2
    }
    
    private var  radiusSmall: CGFloat {
        return radiusBig - circleLineWidth * 2
    }
    
    private var circleLineWidth: CGFloat = 2
    
    
    override func draw(_ rect: CGRect) {
        
        drawEmptyCircle()
        if isActive {
            drawFilledCircle()
        }
    }
    
    
    private func drawEmptyCircle() {
        
        let circleRect = CGRect(x: bounds.width / 2 - radiusBig + circleLineWidth / 2,
                                y: bounds.height / 2 - radiusBig + circleLineWidth / 2,
                                width: radiusBig * 2 - circleLineWidth,
                                height: radiusBig * 2 - circleLineWidth)
        let circle = UIBezierPath(ovalIn: circleRect)
        circle.lineWidth = circleLineWidth
        color.setStroke()
        circle.stroke()
    }
    
    private func drawFilledCircle() {
        
        let circleRect = CGRect(x: bounds.width / 2 - radiusSmall,
                                y: bounds.height / 2 - radiusSmall,
                                width: radiusSmall * 2,
                                height: radiusSmall * 2)
        let circle = UIBezierPath(ovalIn: circleRect)
        color.setFill()
        circle.fill()
    }
    
    @objc func turnOnOff() {
        if !firstLoad {
            setNeedsDisplay()
            post()
        } else {
            firstLoad = false
        }
    }
    
    
}
