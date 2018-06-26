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

    var newEvent = EventClass()
    var eventArr = Array<EventClass>()
    var gameArr = Array<EventClass>()

    @IBOutlet var myCollectionView: UICollectionView!

    @IBOutlet var upBtn: UIButton!
    @IBOutlet var downBtn: UIButton!
    @IBOutlet var lefBtn: UIButton!
    @IBOutlet var rightBtn: UIButton!
    @IBOutlet var enterBtn: UIButton!

    @IBOutlet var bgIV: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {

        // 所有navigationbar 透明化
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = "請依日期 排列事件"


        self.view.backgroundColor = UIColor(red: 0.9, green: 1, blue: 0.9, alpha: 1)
        bgIV.image = UIImage(named: "background.jpg")
        bgIV.contentMode = UIViewContentMode.scaleAspectFill
        bgIV.alpha = 0.1

        upBtn.setImage(Graphics.getUpImage(), for: UIControlState.normal)
        downBtn.setImage(Graphics.getDownImage(), for: UIControlState.normal)
        lefBtn.setImage(Graphics.getLeftImage(), for: .normal)
        rightBtn.setImage(Graphics.getRightImage(), for: .normal)
        enterBtn.setImage(Graphics.getEnterImage(), for: .normal)

        eventArr = myArr
        myCollectionView.isScrollEnabled = false
        firstStart()
    }


//MARK: - Define Function
    func firstStart(){
        guard eventArr.count > 0 else {
            showAlert(title: "題目已出完", msg: "", confirm: "確定")
            return
        }
        (newEvent) = takeStrAndRemoveElem()
        nextRound()
        (newEvent) = takeStrAndRemoveElem()
    }

    func nextRound(){
        gameArr = gameArr.filter{$0.event != ""}
        gameArr.append(newEvent)
        gameArr = quickSorting(arr: gameArr)
        gameArr = insertSpace(arr: gameArr)
        myCollectionView.reloadData()
    }

    func takeStrAndRemoveElem() -> EventClass{
        let myNewEvent = EventClass()
        myNewEvent.event = ""
        myNewEvent.date = ""
        guard eventArr.count > 0 else {
            showAlert(title: "題目已出完", msg: "", confirm: "確定")
            return myNewEvent
        }
        let showEventIndex = randInt(num: eventArr.count)
        myNewEvent.event = eventArr[showEventIndex].event
        myNewEvent.date = eventArr[showEventIndex].date
        eventArr = eventArr.filter{$0.event != myNewEvent.event}
        return myNewEvent
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
        guard newEvent.event != "" else {
            showAlert(title: "題目已出完", msg: "", confirm: "確定")
            return
        }
        switch selectIndex {
        case 0:
            if gameArr[1].date > newEvent.date {
                let alert = UIAlertController(title: "答對了", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "下一題", style: .cancel, handler: {
                    (action: UIAlertAction!) -> Void in
                    self.nextRound()
                    self.newEvent = self.takeStrAndRemoveElem()
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }else{
                showAlert(title: "", msg: "答錯了", confirm: "重來")
            }
            break
        case gameArr.count - 1:
            if gameArr[gameArr.count-2].date < newEvent.date {
                let alert = UIAlertController(title: "答對了", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "下一題", style: .cancel, handler: {
                    (action: UIAlertAction!) -> Void in
                    self.nextRound()
                    self.newEvent = self.takeStrAndRemoveElem()
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }else{
                showAlert(title: "", msg: "答錯了", confirm: "重來")
            }
            break
        default:
            if gameArr[selectIndex-1].date < newEvent.date &&
               gameArr[selectIndex+1].date > newEvent.date {
                let alert = UIAlertController(title: "答對了", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "下一題", style: .cancel, handler: {
                    (action: UIAlertAction!) -> Void in
                    self.nextRound()
                    self.newEvent = self.takeStrAndRemoveElem()
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }else{
                showAlert(title: "", msg: "答錯了", confirm: "重來")
            }
            break
        }
    }

    @IBAction func leftClick(_ sender: UIButton) {
        selectIndex -= selectIndex > 0 ? 2 : 0
        myCollectionView.reloadData()
        let index = IndexPath(item: selectIndex, section: 0)
        myCollectionView.scrollToItem(at: index, at: .centeredVertically, animated: true)
    }

    @IBAction func upClick(_ sender: UIButton) {
        selectIndex -= selectIndex > 0 ? 2 : 0
        myCollectionView.reloadData()
        let index = IndexPath(item: selectIndex, section: 0)
        myCollectionView.scrollToItem(at: index, at: .centeredVertically, animated: true)
    }

    @IBAction func rightClick(_ sender: UIButton) {
        selectIndex += selectIndex < gameArr.count - 1 ? 2 : 0
        myCollectionView.reloadData()
        let index = IndexPath(item: selectIndex, section: 0)
        myCollectionView.scrollToItem(at: index, at: .centeredVertically, animated: true)
    }

    @IBAction func downClick(_ sender: UIButton) {
        selectIndex += selectIndex < gameArr.count - 1 ? 2 : 0
        myCollectionView.reloadData()
        let index = IndexPath(item: selectIndex, section: 0)
        myCollectionView.scrollToItem(at: index, at: .centeredVertically, animated: true)
    }


//MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! MyCollectionViewCell
        cell.layer.borderWidth = indexPath.item == selectIndex ? 1 : 0
        //cell.cardLabel.font = UIFont.boldSystemFont(ofSize: 14)
        cell.cardLabel.adjustsFontSizeToFitWidth = true
        cell.cardLabel.text = gameArr[indexPath.item].event == "" ? "" : gameArr[indexPath.item].event + "\n" + gameArr[indexPath.item].date
        if indexPath.item == selectIndex{
            cell.cardLabel.text = newEvent.event
        }
        cell.backgroundColor = indexPath.item == selectIndex ? UIColor.yellow : UIColor.clear
        return cell
    }


//MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize:CGSize = CGSize(width: myCollectionView.frame.width/2, height: 40)
        return cellSize
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
