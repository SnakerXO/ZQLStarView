//
//  ZQLStarView.swift
//  HappyCalendar
//
//  Created by 臧其龙 on 16/3/31.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

import UIKit

typealias starViewCallback = (CGFloat) -> ()

class ZQLStarView: UIView {
    
    private var emptyStarImage:UIImage?
    private var fillStarImage:UIImage?
    
    private var maskLayer = CAShapeLayer()
    private var fullStarView = UIView()
    
    private var starWidth:CGFloat = 0
    
    var minimCount = 0
    var maximaCount = 5
    
    var isHalfScoreModelOpen = true
    var isTapOpen = true
    var isLongPressOpen = true
    
    var starCount = 0
    
    var callback:starViewCallback?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame:CGRect, emptyImage:UIImage, fillImage:UIImage, count:Int) {
        super.init(frame: frame)
        self.emptyStarImage = emptyImage
        self.fillStarImage = fillImage
        starCount = count
        
        self.fullStarView.frame = self.bounds
        self.addSubview(self.fullStarView)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ZQLStarView.handleLongPressGesture(_:)))
        self.addGestureRecognizer(longPressGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ZQLStarView.handleTapGesture(_:)))
        self.addGestureRecognizer(tapGesture)
        
        initializeStarImageView()
        maskLayer.path = UIBezierPath(rect: CGRectZero).CGPath
        fullStarView.layer.mask = maskLayer
    }
    
    private func initializeStarImageView() {
        starWidth = CGRectGetWidth(self.frame)/CGFloat(starCount)
        for index in 0..<starCount {
            let emptyStarImageView = UIImageView(image: emptyStarImage!)
            emptyStarImageView.frame = CGRect(x: CGFloat(index) *  starWidth, y: 0, width: starWidth, height: starWidth)
            self.addSubview(emptyStarImageView)
            
            let filledStarImageView = UIImageView(image: fillStarImage!)
            filledStarImageView.frame = CGRect(x: CGFloat(index) *  starWidth, y: 0, width: starWidth, height: starWidth)
            fullStarView.addSubview(filledStarImageView)
        }
    }
    
    private func maskLayerPath(gesture:UIGestureRecognizer, view:UIView, starWidth:CGFloat, layer:CAShapeLayer) {
        let currentPoint = gesture.locationInView(view)
        let currentRect = CGRect(x: 0, y: 0, width: currentPoint.x, height: starWidth)
        layer.path = UIBezierPath(rect: currentRect).CGPath
    }
    
    private func handleGestureEnded(gesture:UIGestureRecognizer, view:UIView, starWidth:CGFloat, layer:CAShapeLayer) {
        var finalRate:CGFloat = 0
        let layerLength = gesture.locationInView(view).x
        let rate = layerLength/starWidth
        if isHalfScoreModelOpen {
            
            let integralNumber = Int(rate)
            let decimal = rate - CGFloat(integralNumber)
            switch decimal {
            case 0..<0.3:
                finalRate = CGFloat(integralNumber)
                let currentRect = CGRect(x: 0, y: 0, width: finalRate*starWidth, height: starWidth)
                layer.path = UIBezierPath(rect: currentRect).CGPath
                break
            case 0.3..<0.6:
                finalRate = CGFloat(integralNumber) + 0.5
                let currentRect = CGRect(x: 0, y: 0, width: finalRate*starWidth, height: starWidth)
                layer.path = UIBezierPath(rect: currentRect).CGPath
                break
            case 0.6...1:
                finalRate = CGFloat(integralNumber) + 1
                let currentRect = CGRect(x: 0, y: 0, width: finalRate*starWidth, height: starWidth)
                layer.path = UIBezierPath(rect: currentRect).CGPath
                break
            default:
                break
            }
            
            if let callbackExist = callback {
                if finalRate <= 0 {
                    callbackExist(CGFloat(minimCount))
                }else {
                    let finalScore = finalRate/CGFloat(starCount)*CGFloat(maximaCount)
                    if Int(finalScore) >= maximaCount {
                        callbackExist(CGFloat(maximaCount))
                    }else {
                        callbackExist(finalScore)
                    }
                    
                }
                
            }
        }else{
            maskLayerPath(gesture, view: self, starWidth: starWidth, layer: maskLayer)
            finalRate = rate
            if let callbackExist = callback {
                if finalRate <= 0 {
                    callbackExist(CGFloat(minimCount))
                }else {
                    let finalScore = finalRate/CGFloat(starCount)*CGFloat(maximaCount)
                    if Int(finalScore) >= maximaCount {
                        callbackExist(CGFloat(maximaCount))
                    }else {
                        callbackExist(finalScore)
                    }
                    
                }
            }
        }
    }
    
    func handleLongPressGesture(gesture:UILongPressGestureRecognizer) -> Void {
        if isLongPressOpen {
            switch gesture.state {
            case .Began:
                maskLayerPath(gesture, view: self, starWidth: starWidth, layer: maskLayer)
            case .Changed:
                maskLayerPath(gesture, view: self, starWidth: starWidth, layer: maskLayer)
                break
            case .Ended:
                handleGestureEnded(gesture, view: self, starWidth: starWidth, layer: maskLayer)
                break
            default:
                break
            }
        }
        
    }
    
    func handleTapGesture(gesture:UITapGestureRecognizer) {
        if isTapOpen {
            handleGestureEnded(gesture, view: self, starWidth: starWidth, layer: maskLayer)
        }
    }

}
