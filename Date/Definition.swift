//
//  Definition.swift
//  Date
//
//  Created by Jim Chuang on 2018/6/8.
//  Copyright © 2018年 jj. All rights reserved.
//

import Foundation

func DLog<T> (message: T, fileName: String = #file, funcName: String = #function, lineNum: Int = #line) {

    #if DEBUG

    let file = (fileName as NSString).lastPathComponent

    print("-\(file) \(funcName)-[\(lineNum)]: \(message)")

    #endif

}

func randInt(num:Int) -> Int{
    return Int(arc4random_uniform(UInt32(num)))
}

func myArrClean(){
    myArr = Array(repeating: "", count: 366)
}

func insertSpace(arr:Array<String>) -> Array<String> {
    var resultArr = Array<String>()
    for i in 0...arr.count - 1{
        resultArr.append("")
        resultArr.append(arr[i])
    }
    resultArr.append("")
    return resultArr
}

func quickSorting(arr:Array<String>) -> Array<String>{
    guard arr.count > 1 else { return arr }
    let pivotSelect = arr.count/2
    let pivot = arr[pivotSelect]
    let pivotArray = [pivot]
    var less = Array<String>()
    var greater = Array<String>()
    for i in 0...arr.count - 1
    {
        if i != pivotSelect && myArr.index(of: arr[i])! <= myArr.index(of: pivot)!
        {
            less.append(arr[i])
        }
        if i != pivotSelect && myArr.index(of: arr[i])! > myArr.index(of: pivot)!
        {
            greater.append(arr[i])
        }
    }
    return quickSorting(arr:less) + pivotArray + quickSorting(arr:greater)
}
