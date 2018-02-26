//: # Bezier Paths 1. Basic shapes
//: This section shows the basics of UIBezierPath, how it can be used to describe custom shapes and generate images with them.
//: We will be using the CoreGraphics API fro drawing our shapes into images.

import UIKit

//: This extension on UIImage will allow us to generate a UIImage for a given UIBezierPath.
extension UIImage {
    class func shapeImageWithBezierPath(bezierPath: UIBezierPath, fillColor: UIColor?, strokeColor: UIColor?, strokeWidth: CGFloat = 0.0) -> UIImage! {
        //: Normalize bezier path. We will apply a transform to our bezier path to ensure that it's placed at the coordinate axis. Then we can get its size.
        bezierPath.apply(CGAffineTransform(translationX: -bezierPath.bounds.origin.x, y: -bezierPath.bounds.origin.y))
        let size = CGSize(width: bezierPath.bounds.size.width, height: bezierPath.bounds.size.height)
        
        //: Initialize an image context with our bezier path normalized shape and save current context
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.saveGState()
        
        //: Set path
        context.addPath(bezierPath.cgPath)
        //: Set parameters and draw
        if strokeColor != nil {
            strokeColor!.setStroke()
            context.setLineWidth(strokeWidth)
        } else { UIColor.clear.setStroke() }
        fillColor?.setFill()
        context.drawPath(using: .fillStroke)

        //: Get the image from the current image context
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //: Restore context and close everything
        context.restoreGState()
        UIGraphicsEndImageContext()
        //: Return image
        return image
    }
}

let size = CGSize(width: 120, height: 100)
let π = CGFloat(Double.pi)
var center = CGPoint()
var radius = CGFloat()
var x: CGFloat = 300 / 2
var y: CGFloat = 300 / 2
var depth: CGFloat = 5
var width: CGFloat = 50.0
var height: CGFloat = 50.0
var startAngle:CGFloat = 0
var endAngle:CGFloat = 180
let linePath = UIBezierPath()

for i in 1..<10 {
    if i % 2 == 0 {
        x = x + 2 * depth
        y = y - depth
        width = width + 2 * depth
        height = height + 2 * depth
        linePath.addArc(withCenter: CGPoint(x: x, y: y), radius: width, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    } else {
        x = x - 2 * depth
        y = y - depth
        width = width + 2 * depth
        height = height + 2 * depth
        linePath.addArc(withCenter: CGPoint(x: x, y: y), radius: width, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    }
}
let spiralShape = UIImage.shapeImageWithBezierPath(bezierPath: linePath, fillColor: UIColor.clear, strokeColor: UIColor.white, strokeWidth: 1.0)


/*let size = CGSize(width: 120, height: 100)
let π = CGFloat(Double.pi)
var center = CGPoint()
var radius = CGFloat()
var startAngle:CGFloat = 3*π/2
var endAngle:CGFloat = 0

center = CGPoint(x:150, y: 150)

radius = 300/90

let coeff: CGFloat = 2.0

let linePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

// 2 - 9 arcs
for _ in 2..<10 {
    
    startAngle = endAngle
    
    switch startAngle {
    case 0, 2*π:
        center = CGPoint(x: center.x - radius/2, y: center.y)
        endAngle = π/2
    case π:
        center = CGPoint(x: center.x + radius/2, y: center.y)
        endAngle = 3*π/2
    case π/2:
        center = CGPoint(x: center.x  , y: center.y - radius/2)
        endAngle = π
    case 3*π/2:
        center = CGPoint(x: center.x, y: center.y + radius/2)
        endAngle = 2*π
    default:
        center = CGPoint(x:150, y: 150)
    }
    
    radius = 1.5 * radius
    linePath.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle,clockwise: true)
}

let spiralShape = UIImage.shapeImageWithBezierPath(bezierPath: linePath, fillColor: UIColor.clear, strokeColor: UIColor.white, strokeWidth: 1.0)*/




