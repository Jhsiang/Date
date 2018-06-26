//
//  Graphics.swift
//  Date
//
//  Created by Jim Chuang on 2018/6/25.
//  Copyright © 2018年 jj. All rights reserved.
//

import UIKit

class Graphics: NSObject {

    class func getEnterImage() -> UIImage {

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 120, height: 180), false, 1)

        let color3 = UIColor(red: 1, green: 0.429, blue: 0.485, alpha: 0.5)
        let color4 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)

        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 35, y: 65, width: 50, height: 50))
        color3.setFill()
        ovalPath.fill()
        color4.setStroke()
        ovalPath.lineWidth = 5
        ovalPath.stroke()

        return UIGraphicsGetImageFromCurrentImageContext()!;
    }

    class func getDownImage() -> UIImage {

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 85, height: 90), false, 1)

        let color = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)

        let polygonPath = UIBezierPath()
        polygonPath.move(to: CGPoint(x: 42, y: 18))
        polygonPath.addLine(to: CGPoint(x: 5, y: 42))
        polygonPath.addLine(to: CGPoint(x: 5, y: 80))
        polygonPath.addLine(to: CGPoint(x: 79, y: 80))
        polygonPath.addLine(to: CGPoint(x: 79, y: 42))
        polygonPath.addLine(to: CGPoint(x: 42, y: 18))
        polygonPath.close()

        color.setFill()
        polygonPath.fill()

        return UIGraphicsGetImageFromCurrentImageContext()!;
    }

    class func getUpImage() -> UIImage {

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 85, height: 90), false, 1)

        let color = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)

        let polygonPath = UIBezierPath()
        polygonPath.move(to: CGPoint(x: 42, y: 82))
        polygonPath.addLine(to: CGPoint(x: 5, y: 48))
        polygonPath.addLine(to: CGPoint(x: 5, y: 10))
        polygonPath.addLine(to: CGPoint(x: 79, y: 10))
        polygonPath.addLine(to: CGPoint(x: 79, y: 48))
        polygonPath.addLine(to: CGPoint(x: 42, y: 82))
        polygonPath.close()

        color.setFill()
        polygonPath.fill()

        return UIGraphicsGetImageFromCurrentImageContext()!;
    }

    class func getLeftImage() -> UIImage {

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 85, height: 180), false, 1)

        let color = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)

        let polygonPath = UIBezierPath()
        polygonPath.move(to: CGPoint(x: 85, y: 90))
        polygonPath.addLine(to: CGPoint(x: 61, y: 127))
        polygonPath.addLine(to: CGPoint(x: 23, y: 127))
        polygonPath.addLine(to: CGPoint(x: 23, y: 53))
        polygonPath.addLine(to: CGPoint(x: 61, y: 53))
        polygonPath.addLine(to: CGPoint(x: 85, y: 90))
        polygonPath.close()

        color.setFill()
        polygonPath.fill()

        return UIGraphicsGetImageFromCurrentImageContext()!;
    }

    class func getRightImage() -> UIImage {

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 85, height: 180), false, 1)

        let color = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)

        let polygonPath = UIBezierPath()
        polygonPath.move(to: CGPoint(x: 0, y: 90))
        polygonPath.addLine(to: CGPoint(x: 24, y: 127))
        polygonPath.addLine(to: CGPoint(x: 62, y: 127))
        polygonPath.addLine(to: CGPoint(x: 62, y: 53))
        polygonPath.addLine(to: CGPoint(x: 24, y: 53))
        polygonPath.addLine(to: CGPoint(x: 0, y: 90))
        polygonPath.close()

        color.setFill()
        polygonPath.fill()

        return UIGraphicsGetImageFromCurrentImageContext()!;
    }



    class func getAddImageNormal() -> UIImage {

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 240, height: 120), false, 1.0)

        //// Color Declarations
        let color = UIColor(red: 1.000, green: 0.000, blue: 1.000, alpha: 1.000)

        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0.5, y: 50.5, width: 239, height: 20))
        color.setFill()
        rectanglePath.fill()
        color.setStroke()
        rectanglePath.lineWidth = 1
        rectanglePath.stroke()

        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRect(x: 110, y: 0.5, width: 20, height: 119))
        color.setFill()
        rectangle2Path.fill()
        color.setStroke()
        rectangle2Path.lineWidth = 1
        rectangle2Path.stroke()

        //// Star Drawing
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x: 36, y: 13.5))
        starPath.addLine(to: CGPoint(x: 40.41, y: 18.9))
        starPath.addLine(to: CGPoint(x: 47.89, y: 20.76))
        starPath.addLine(to: CGPoint(x: 43.13, y: 25.95))
        starPath.addLine(to: CGPoint(x: 43.35, y: 32.49))
        starPath.addLine(to: CGPoint(x: 36, y: 30.3))
        starPath.addLine(to: CGPoint(x: 28.65, y: 32.49))
        starPath.addLine(to: CGPoint(x: 28.87, y: 25.95))
        starPath.addLine(to: CGPoint(x: 24.11, y: 20.76))
        starPath.addLine(to: CGPoint(x: 31.59, y: 18.9))
        starPath.close()
        color.setFill()
        starPath.fill()
        color.setStroke()
        starPath.lineWidth = 1
        starPath.stroke()

        return UIGraphicsGetImageFromCurrentImageContext()!;
    }

    class func getAddImageSelect() -> UIImage {

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 239, height: 119), false, 1.0)

        // This code was generated by Trial version of PaintCode, therefore cannot be used for commercial purposes.
        // http://www.paintcodeapp.com

        //// Color Declarations
        let color4 = UIColor(red: 0.800, green: 0.320, blue: 0.320, alpha: 1.000)

        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0.5, y: 49.5, width: 239, height: 20))
        color4.setFill()
        rectanglePath.fill()
        color4.setStroke()
        rectanglePath.lineWidth = 1
        rectanglePath.stroke()


        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRect(x: 110, y: 0.5, width: 20, height: 119))
        color4.setFill()
        rectangle2Path.fill()
        color4.setStroke()
        rectangle2Path.lineWidth = 1
        rectangle2Path.stroke()


        //// Star Drawing
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x: 36, y: 13.5))
        starPath.addLine(to: CGPoint(x: 40.41, y: 18.9))
        starPath.addLine(to: CGPoint(x: 47.89, y: 20.76))
        starPath.addLine(to: CGPoint(x: 43.13, y: 25.95))
        starPath.addLine(to: CGPoint(x: 43.35, y: 32.49))
        starPath.addLine(to: CGPoint(x: 36, y: 30.3))
        starPath.addLine(to: CGPoint(x: 28.65, y: 32.49))
        starPath.addLine(to: CGPoint(x: 28.87, y: 25.95))
        starPath.addLine(to: CGPoint(x: 24.11, y: 20.76))
        starPath.addLine(to: CGPoint(x: 31.59, y: 18.9))
        starPath.close()
        color4.setFill()
        starPath.fill()
        color4.setStroke()
        starPath.lineWidth = 1
        starPath.stroke()

        return UIGraphicsGetImageFromCurrentImageContext()!;
    }

}
