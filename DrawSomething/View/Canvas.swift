//
//  Canvas.swift
//  DrawSomething
//
//  Created by Ata Etgi on 24.04.2021.
//

import UIKit

class Canvas: UIView {
    
    
    // public functions
    
    func undo() {
        
        _ = lines.popLast()
        layer.setNeedsLayout()
        layer.displayIfNeeded()

        setNeedsDisplay()
        
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 10
    
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    
    func setStrokeWidth(width: Float) {
        self.strokeWidth = .init(width)
    }
    
    private var lines = [Line]()

    override func draw(_ rect: CGRect) {
        // allow us to custom drawing
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // here are my lines
        // dummy data
//        let startPoint = CGPoint(x: 0, y: 0)
//        let endPoint = CGPoint(x: 100, y: 100)
//
//        context.move(to: startPoint)
//        context.addLine(to: endPoint)
                


        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            
            context.strokePath()

        }
        
        
    }
    // let's ditch this line
//    var line = [CGPoint]()
    
    
    //track the finger as we move across screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
//        print(point)
        
//        line.append(point)
        
        guard var lastLine = lines.popLast() else { return } // Removes and returns the last element of the collection.
        lastLine.points.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay() //  redraws
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            lines.append(Line(color: strokeColor, strokeWidth: strokeWidth, points: []))
    }
    

}
