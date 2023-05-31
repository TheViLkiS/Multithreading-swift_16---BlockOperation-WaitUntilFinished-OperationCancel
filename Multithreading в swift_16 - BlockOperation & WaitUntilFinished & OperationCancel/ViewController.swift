//
//  ViewController.swift
//  Multithreading в swift_16 - BlockOperation & WaitUntilFinished & OperationCancel
//
//  Created by Дмитрий Гусев on 31.05.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        
        let operationQueue = OperationQueue()
        
        class OperationCancellTest: Operation {
            override func main() {
                
                if isCancelled {
                    print(isCancelled)
                    return
                }
                
                print("test 1")
                sleep(1)
                
                if isCancelled {
                    print(isCancelled)
                    return
                }
                
                print("test 2")

            }
        }
        
        func cancelOperationMethod() {
            let cancelOperation = OperationCancellTest()
            
            operationQueue.addOperation(cancelOperation)
            sleep(1)
            cancelOperation.cancel()
        }
        
//        cancelOperationMethod()

        
        class WaitOperation {
            private let operationQueue = OperationQueue()
            
            func test() {
                operationQueue.addOperation {
                    sleep(1)
                    print("test 1")
                }
                operationQueue.addOperation {
                    sleep(2)
                    print("test 2")
                }
                operationQueue.waitUntilAllOperationsAreFinished()
                
                
                operationQueue.addOperation {
                    print("test 3")
                }
                
                
                operationQueue.addOperation {
                    print("test 4")
                    
                }
            }
        }
        let waitOperation = WaitOperation()
        
//        waitOperation.test()
        
        
        class WaitOperationTest2 {
            private let operationQueue = OperationQueue()
            
            func test() {
                
                let operation1 = BlockOperation {
                    sleep(1)
                    print("test 1")
                    print(Thread.current)

                }
                let operation2 = BlockOperation {
                    sleep(2)
                    print("test 2")
                    print(Thread.current)
                }
                
                operationQueue.addOperations([operation2, operation1], waitUntilFinished: true)
                
                operationQueue.addOperation {
                    print("finish")
                    print(Thread.current)

                }
                
            }
        }
        
        let waitOperation2 = WaitOperationTest2()
//        waitOperation2.test()
        
        class CompletionBlock {
            private let operationQueue = OperationQueue()
            
            func test() {
                
                let operation1 = BlockOperation {
                    sleep(1)
                    print("test  block 1")
                    print(Thread.current)
                }
                
                operation1.completionBlock = {
                    print("finish block 1")
                }
                
                let operation2 = BlockOperation {
                    sleep(2)
                    print("test block 2")
                    print(Thread.current)

                }
                operation2.completionBlock = {
                    print("finish block 2")
                }
                
                operationQueue.addOperation(operation1)
                operationQueue.addOperation(operation2)

            }
        }
        
       var completionBlock = CompletionBlock()
        completionBlock.test()
        
    }
}

