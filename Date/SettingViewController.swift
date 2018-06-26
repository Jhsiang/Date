//
//  ViewController.swift
//  Date
//
//  Created by Jim Chuang on 2018/6/7.
//  Copyright © 2018年 jj. All rights reserved.
//

import UIKit

var myArr = Array<EventClass>()

class SettingViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var myDP: UIDatePicker!
    @IBOutlet var myTF: UITextField!
    @IBOutlet var myTFView: UIView!

    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var clearBtn: UIButton!
    @IBOutlet var startBtn: UIButton!

    @IBOutlet var countLabel: UILabel!
    @IBOutlet var bgIV: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // test
        print("\(numToDate(i: 248))")
        print("\(dateToNum(m: 1, d: 3))")
        print("\(dateToNum(m: 7, d: 7))")
    }

    override func viewWillAppear(_ animated: Bool) {
        
//        UIView.animate(withDuration: 3) {
//            <#code#>
//        }

        bgIV.image = UIImage(named: "background.jpg")
        bgIV.contentMode = UIViewContentMode.scaleAspectFill
        bgIV.alpha = 0.05

        //animateWithDuration
        // 字寬
        titleLabel.adjustsFontSizeToFitWidth = true
        myTF.adjustsFontSizeToFitWidth = true
        countLabel.adjustsFontSizeToFitWidth = true

        // DatePicker 事件
        myDP.addTarget(self, action: #selector(dpValueChange), for: .valueChanged)

        // count label
        myArr = loadEventClass()
        countLabel.text = "已儲存的事件: \(myArr.count)件"

        // 註冊鍵盤出現/消失事件
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        // 取消註冊鍵盤出現/消失事件
        NotificationCenter.default.removeObserver(self,name:NSNotification.Name.UIKeyboardWillShow, object:nil)
        NotificationCenter.default.removeObserver(self,name:NSNotification.Name.UIKeyboardWillHide, object:nil)
    }


//MARK: - Define Function
    func countLabelRefresh(){
        myArr = loadEventClass()
        countLabel.text = "已儲存的事件: \(myArr.count)件"
    }

    func showAlert(title:String,msg:String,confirm:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: confirm, style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func presentToMain(){
        self.performSegue(withIdentifier: "seque_setting_to_main", sender: self)
    }


//MARK: - DataPicker observer
    @objc func dpValueChange(){

        let mFormatter = DateFormatter()
        mFormatter.dateFormat = "MM"
        let dFormatter = DateFormatter()
        dFormatter.dateFormat = "dd"

        let mInt = Int(mFormatter.string(from: myDP.date))
        let dInt = Int(dFormatter.string(from: myDP.date))

        DLog(message: mInt)
        DLog(message: dInt)
    }


//MARK: - Keyboard Observer
    @objc func keyboardWillShow(note: NSNotification) {
        let userInfo = note.userInfo!
        let keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let kybHeight = keyBoardBounds.size.height
        let deltaY = self.myTFView.frame.origin.y + self.myTFView.frame.size.height + kybHeight - self.view.frame.size.height
        if deltaY > 0{
            self.view.transform = CGAffineTransform(translationX: 0, y: -deltaY)
        }
    }

    @objc func keyboardWillHidden(note: NSNotification) {
        self.view.transform = CGAffineTransform.identity
    }


//MARK: - UITextfieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTF.resignFirstResponder()
        return true
    }


//MARK: - Button Click
    @IBAction func saveClick(_ sender: UIButton) {

        if myTF.text == "" {
            showAlert(title: "空白", msg: "請輸入資訊", confirm: "確認")
            return
        }

        if let eventStr = myTF.text{
            let checkEvent = myArr.filter{$0.event == eventStr}
            if checkEvent.count == 0 {
                let dateStr = translate(d: myDP.date)
                let checkDate = myArr.filter(){$0.date == dateStr}
                if checkDate.count == 0{
                    let event = EventClass()
                    event.event = eventStr
                    event.date = dateStr
                    myArr.append(event)
                    saveEventClass(eveClas: myArr)
                    countLabelRefresh()
                }else{
                    let alert = UIAlertController(title:"" , message: "覆蓋"+"【"+myArr.filter{$0.date == dateStr}[0].event+"】", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                    let okAction = UIAlertAction(title: "覆蓋", style: .default, handler: {
                        (action:UIAlertAction!) -> Void in
                        let event = EventClass()
                        event.event = eventStr
                        event.date = dateStr
                        myArr = myArr.filter{$0.date != dateStr}
                        myArr.append(event)
                        saveEventClass(eveClas: myArr)
                        self.countLabelRefresh()
                    })
                    alert.addAction(cancelAction)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                showAlert(title: "已有相同的事件", msg: "", confirm: "確認")
            }
        }else{
            showAlert(title: "未知錯誤", msg: "TextField為nil", confirm: "確認")
        }
    }

    @IBAction func startClick(_ sender: UIButton) {
        presentToMain()
    }
    
    @IBAction func cleanClick(_ sender: UIButton) {
        myArrClean()
        cleanEvent()
        countLabelRefresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

