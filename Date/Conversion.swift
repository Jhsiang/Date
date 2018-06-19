//
//  Conversion.swift
//  Date
//
//  Created by Jim Chuang on 2018/6/7.
//  Copyright © 2018年 jj. All rights reserved.
//

import Foundation

func numToDate(i:Int) -> String{


    var arr = [30,29,31,30,31,30,31,31,30,31,30,31]
    var str = ""
    var myInt = i
    for x in 0...arr.count-1{
        if myInt > arr[x]{
            myInt -= arr[x]
        }else{
            str = x == 0 ? "\(x+1)/\(myInt+1)" : "\(x+1)/\(myInt)"
            break
        }
    }
    return str
}

func dateToNum(m:Int,d:Int) -> Int{

    var resultI = 0
    var arr = [30,29,31,30,31,30,31,31,30,31,30,31]
    for x in 0...arr.count-1{
        if m > x+1 {
            resultI += arr[x]
        }else{
            resultI += m == 1 ? d - 1 : d
            break
        }
    }

    return resultI
}

func dateFmatToInt(myDate:Date) -> (m:Int,d:Int){
    let mFormatter = DateFormatter()
    mFormatter.dateFormat = "MM"
    let dFormatter = DateFormatter()
    dFormatter.dateFormat = "dd"

    let mInt = Int(mFormatter.string(from: myDate))!
    let dInt = Int(dFormatter.string(from: myDate))!

    return (mInt,dInt)
}

func translate(d:Date) -> String{
    let myDateformat = DateFormatter()
    myDateformat.dateFormat = "YYYY/MM/dd"
    let str = myDateformat.string(from: d)
    return str
}
