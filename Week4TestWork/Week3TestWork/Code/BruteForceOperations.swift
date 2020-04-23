//
//  BruteForceOperations.swift
//  Week3TestWork
//
//  Created by Aleksey Bardin on 18.04.2020.
//  Copyright © 2020 E-legion. All rights reserved.
//

import Foundation

//Задача
//
//Переделать данный проект с использованием OperationQueue и Operation вместо GCD
//Создать сабкласс Operation, в котором реализовать всю логику по подбору пароля
//Реализовать логику, в которой, когда одна операция найдет пароль, другие должны завершить свое выполнение.
//Для обновления UI можно использовать по желанию OperationQueue.main или DispatchQueue.main

class BruteForceOperations: Operation {
    
    private let characterArray = Consts.characterArray
    private var password: String
    private var startString: String
    private var endString: String
    public var result: String? {
        didSet {
            cancel()
        }
    }
    
    init(startString: String, endString: String, password: String) {
        self.startString = startString
        self.endString = endString
        self.password = password
    }
    
    override func main() {
        guard !isCancelled else { return }
        
        let inputPassword = password
        var startIndexArray = [Int]()
        var endIndexArray = [Int]()
        let maxIndexArray = characterArray.count
        
        // Создает массивы индексов из входных строк
        for char in startString {
            for (index, value) in characterArray.enumerated() where value == "\(char)" {
                startIndexArray.append(index)
            }
        }
        
        for char in endString {
            for (index, value) in characterArray.enumerated() where value == "\(char)" {
                endIndexArray.append(index)
            }
        }
        
        var currentIndexArray = startIndexArray
        
        // Цикл подбора пароля
        while  (!isCancelled) {
            
            // Формируем строку проверки пароля из элементов массива символов
            let currentPass = self.characterArray[currentIndexArray[0]] +
                self.characterArray[currentIndexArray[1]] +
                self.characterArray[currentIndexArray[2]] +
                self.characterArray[currentIndexArray[3]]

            // Выходим из цикла если пароль найден, или, если дошли до конца массива индексов
            if inputPassword == currentPass {
                result = currentPass
            } else {
                if currentIndexArray.elementsEqual(endIndexArray) {
                    break
                }
                
                for index in (0 ..< currentIndexArray.count).reversed() {
                    guard currentIndexArray[index] < maxIndexArray - 1 else {
                        currentIndexArray[index] = 0
                        continue
                    }
                    currentIndexArray[index] += 1
                    break
                }
            }
        }
    }
    
    
}


