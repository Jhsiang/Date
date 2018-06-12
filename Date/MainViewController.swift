//
//  MainViewController.swift
//  Date
//
//  Created by Jim Chuang on 2018/6/8.
//  Copyright © 2018年 jj. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var selectIndex:Int = 0

    var eventStr = ""
    var eventArr = Array<String>()
    var gameArr = Array<String>()

    @IBOutlet var myCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        eventArr = myArr.filter{$0 != ""}
        firstStart()
    }


//MARK: - Define Function
    func firstStart(){
        guard eventArr.count > 0 else {
            showAlert(title: "題目已出完", msg: "", confirm: "確定")
            return
        }
        eventStr = takeStrAndRemoveElem()
        nextRound()
        eventStr = takeStrAndRemoveElem()
    }

    func nextRound(){
        gameArr = gameArr.filter{$0 != ""}
        gameArr.append(eventStr)
        gameArr = quickSorting(arr: gameArr)
        gameArr = insertSpace(arr: gameArr)
        myCollectionView.reloadData()
    }

    func takeStrAndRemoveElem() -> String{
        guard eventArr.count > 0 else {
            showAlert(title: "題目已出完", msg: "", confirm: "確定")
            return ""
        }
        let showEventIndex = randInt(num: eventArr.count)
        let myStr = eventArr[showEventIndex]
        eventArr = eventArr.filter{$0 != myStr}
        return myStr
    }

    func showAlert(title:String,msg:String,confirm:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: confirm, style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func cellDashed(cell:UICollectionViewCell) -> UICollectionViewCell{
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = UIColor.black.cgColor
        yourViewBorder.lineDashPattern = [2, 2]
        yourViewBorder.frame = cell.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.addSublayer(yourViewBorder)
        return cell
    }


//MARK: - Button Click
    @IBAction func resetClick(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "seque_main_to_setting", sender: self)
    }

    @IBAction func enterClick(_ sender: UIButton) {
        guard eventStr != "" else {
            showAlert(title: "題目已出完", msg: "", confirm: "確定")
            return
        }
        switch selectIndex {
        case 0:
            if myArr.index(of: gameArr[1])! > myArr.index(of: eventStr)!{
                showAlert(title: "答對了", msg: "", confirm: "下一題")
            }else{
                showAlert(title: "", msg: "答錯了", confirm: "下一題")
            }
            nextRound()
            eventStr = takeStrAndRemoveElem()
            break
        case gameArr.count - 1:
            if myArr.index(of: gameArr[gameArr.count-2])! < myArr.index(of: eventStr)!{
                showAlert(title: "答對了", msg: "", confirm: "下一題")
            }else{
                showAlert(title: "", msg: "答錯了", confirm: "下一題")
            }
            nextRound()
            eventStr = takeStrAndRemoveElem()
            break
        default:
            if (myArr.index(of: gameArr[selectIndex-1])! < myArr.index(of: eventStr)!) &&
               (myArr.index(of: gameArr[selectIndex+1])! > myArr.index(of: eventStr)!){
                showAlert(title: "答對了", msg: "", confirm: "下一題")
            }else{
                showAlert(title: "", msg: "答錯了", confirm: "下一題")
            }
            nextRound()
            eventStr = takeStrAndRemoveElem()
            break
        }
    }

    @IBAction func leftClick(_ sender: UIButton) {
        selectIndex -= selectIndex > 0 ? 2 : 0
        myCollectionView.reloadData()
    }

    @IBAction func rightClick(_ sender: UIButton) {
        selectIndex += selectIndex < gameArr.count - 1 ? 2 : 0
        myCollectionView.reloadData()
    }


//MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! MyCollectionViewCell
        cell.layer.borderWidth = indexPath.item == selectIndex ? 1 : 0
        cell.cardLabel.adjustsFontSizeToFitWidth = true
        cell.cardLabel.text = gameArr[indexPath.item] == "" ? "" : gameArr[indexPath.item] + "\n" + numToDate(i: myArr.index(of: gameArr[indexPath.item])!)
        if indexPath.item == selectIndex{
            cell.cardLabel.text = eventStr
        }
        cell.backgroundColor = indexPath.item == selectIndex ? UIColor.yellow : UIColor.white
        return cell
    }


//MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize:CGSize = CGSize(width: myCollectionView.frame.width/2, height: 40)
        return cellSize
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
