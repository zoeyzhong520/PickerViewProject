//
//  ViewController.swift
//  PickerViewProject
//
//  Created by zhifu360 on 2019/5/27.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    ///创建UIPickerView
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width - 100, height: 100))
        picker.center = view.center
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    ///数据源
    var dataArray: [[String]] = {
        var tmpArr = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈"]
        var arr1 = [String]()
        var arr2 = [String]()
        var arr3 = [String]()
        for i in 0..<100 {
            arr1.append(tmpArr[Int(arc4random())%tmpArr.count])
            arr2.append(tmpArr[Int(arc4random())%tmpArr.count])
            arr3.append(tmpArr[Int(arc4random())%tmpArr.count])
        }
        return [arr1,arr2,arr3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setPage()
    }

    func setPage() {
        title = "演示"
        view.addSubview(pickerView)
    }
    
    func setNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start", style: .plain, target: self, action: #selector(start))
    }
    
    @objc func start(){
        //开启老虎机🎰
        //随机设置选择的行
        pickerView.selectRow(Int(arc4random()%100), inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random()%100), inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random()%100), inComponent: 2, animated: true)
        //判断选择的行是否相等
        let row0 = pickerView.selectedRow(inComponent: 0)
        let row1 = pickerView.selectedRow(inComponent: 1)
        let row2 = pickerView.selectedRow(inComponent: 2)
        
        if dataArray[0][row0] == dataArray[1][row1] && dataArray[1][row1] == dataArray[2][row2] && dataArray[2][row2] == dataArray[0][row0] {
            //三元素一致
            UIAlertView(title: "提示", message: "恭喜中大奖！", delegate: nil, cancelButtonTitle: "关闭").show()
        }
    }

    
}

extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let array = dataArray[component]
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 70
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.font = UIFont(name: "Apple Color Emoji", size: 70)
        label.textAlignment = .center
        label.text = dataArray[component][row]
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(dataArray[component][row])
    }
    
}

