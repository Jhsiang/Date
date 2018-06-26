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
    myArr = Array<EventClass>()
}

func insertSpace(arr:Array<EventClass>) -> Array<EventClass> {
    var resultArr = Array<EventClass>()
    let emptyElem = EventClass()
    emptyElem.date = ""
    emptyElem.event = ""
    for i in 0...arr.count - 1{
        resultArr.append(emptyElem)
        resultArr.append(arr[i])
    }
    resultArr.append(emptyElem)
    return resultArr
}

func quickSorting(arr:Array<EventClass>) -> Array<EventClass>{
    guard arr.count > 1 else { return arr }
    let pivotSelect = arr.count/2
    let pivot = arr[pivotSelect]
    let pivotArray = [pivot]
    var less = Array<EventClass>()
    var greater = Array<EventClass>()
    for i in 0...arr.count - 1
    {
        if i != pivotSelect && arr[i].date <= pivot.date
        {
            less.append(arr[i])
        }
        if i != pivotSelect && arr[i].date > pivot.date
        {
            greater.append(arr[i])
        }
    }
    return quickSorting(arr:less) + pivotArray + quickSorting(arr:greater)
}

func saveEventClass(eveClas:Array<EventClass>){

    var eventArr = Array<String>()
    var dateArr = Array<String>()
    for i in 0...eveClas.count - 1{
        eventArr.append(eveClas[i].event)
        dateArr.append(eveClas[i].date)
    }

    UserDefaults.standard.set(eventArr, forKey: PREF_KEY_SAVE_EVENT_ARRAY)
    UserDefaults.standard.set(dateArr, forKey: PREF_KEY_SAVE_DATE_ARRAY)
}

func loadEventClass() -> Array<EventClass>{

    var resultArr = Array<EventClass>()
    if let eventArr = UserDefaults.standard.stringArray(forKey: PREF_KEY_SAVE_EVENT_ARRAY) ,
        let dateArr = UserDefaults.standard.stringArray(forKey: PREF_KEY_SAVE_DATE_ARRAY){
        for i in 0...eventArr.count - 1{
            let eveclas = EventClass()
            eveclas.event = eventArr[i]
            eveclas.date = dateArr[i]
            resultArr.append(eveclas)
        }
        return resultArr
    }

    return resultArr
}

func cleanEvent(){
    UserDefaults.standard.removeObject(forKey: PREF_KEY_SAVE_EVENT_ARRAY)
    UserDefaults.standard.removeObject(forKey: PREF_KEY_SAVE_DATE_ARRAY)
}





