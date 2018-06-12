//
//  ViewController.swift
//  Date
//
//  Created by Jim Chuang on 2018/6/7.
//  Copyright © 2018年 jj. All rights reserved.
//

import UIKit

var myArr:Array<String> = Array(repeating: "", count: 366)

class SettingViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var myDP: UIDatePicker!
    @IBOutlet var myTF: UITextField!
    @IBOutlet var myTFView: UIView!

    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var clearBtn: UIButton!
    @IBOutlet var startBtn: UIButton!

    @IBOutlet var countLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // test
        print("\(numToDate(i: 248))")
        print("\(dateToNum(m: 1, d: 3))")
        print("\(dateToNum(m: 7, d: 7))")
    }

    override func viewWillAppear(_ animated: Bool) {

        // 字寬
        titleLabel.adjustsFontSizeToFitWidth = true
        myTF.adjustsFontSizeToFitWidth = true
        countLabel.adjustsFontSizeToFitWidth = true

        // DatePicker 事件
        myDP.addTarget(self, action: #selector(dpValueChange), for: .valueChanged)

        // count label
        if let saveArr = UserDefaults.standard.stringArray(forKey: PREF_KEY_SAVE_EVENT_ARRAY){
            myArr = saveArr
            let eventNum = saveArr.filter{$0 != ""}
            countLabel.text = "已儲存的事件: \(eventNum.count)件"
        }else{
            UserDefaults.standard.set(myArr, forKey: PREF_KEY_SAVE_EVENT_ARRAY)
        }

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
        if let saveArr = UserDefaults.standard.stringArray(forKey: PREF_KEY_SAVE_EVENT_ARRAY){
            let eventNum = saveArr.filter{$0 != ""}
            countLabel.text = "已儲存的事件: \(eventNum.count)件"
        }else{
            UserDefaults.standard.set(myArr, forKey: PREF_KEY_SAVE_EVENT_ARRAY)
            countLabel.text = "已儲存的事件: 0件"
        }
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

        if let tfText = myTF.text{
            let checkRepeat = myArr.filter{$0 == tfText}
            if checkRepeat.count == 0 {
                let (month,day) = dateFmatToInt(myDate: myDP.date)
                let arrLoc = dateToNum(m: month, d: day)
                if myArr[arrLoc] != ""{
                    showAlert(title: "", msg: "原日期已有資料", confirm: "確認覆寫")
                }
                myArr[arrLoc] = tfText
                UserDefaults.standard.set(myArr, forKey: PREF_KEY_SAVE_EVENT_ARRAY)
                countLabelRefresh()
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
        UserDefaults.standard.removeObject(forKey: PREF_KEY_SAVE_EVENT_ARRAY)
        countLabelRefresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

