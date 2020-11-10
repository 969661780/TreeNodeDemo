//
//  AppDelegate.swift
//  dvsvd
//
//  Created by mtt on 2020/11/4.
//

import UIKit
public class TreeNode{
    public var left:TreeNode?
    public var right:TreeNode?
    public var val:Int
    public init(_ val:Int){
        self.val = val
        self.left = nil
        self.right = nil
    }
}
@main

class AppDelegate: UIResponder, UIApplicationDelegate {


    func findRepeatNumber(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
                   return -1
            }
        var nums = nums
        for i in 0..<nums.count {
            if i == nums[i] {
                continue
            }
            if nums[i] == nums[nums[i]] {
                return nums[i]
            }
            nums.swapAt(i, nums[i])
        }
        return -1
//        var numberCount = Set<Int>()
//        var leftIndex = 0
//        var rightIndex = nums.count - 1
//        while rightIndex>leftIndex {
//            if !numberCount.insert(nums[leftIndex]).inserted {
//                return nums[leftIndex]
//            }
//            leftIndex += 1
//            if !numberCount.insert(nums[rightIndex]).inserted {
//                return nums[rightIndex]
//            }
//            rightIndex -= 1
//        }
//        return 0
     }
    func getLeastNumbers(_ arr: [Int], _ k: Int) -> [Int] {
        let leftIndex = 0
        let rightIndex = arr.count - 1
        var arr1 = arr
        var arr2 = [Int]()
        getKLitter(&arr1, leftIndex, rightIndex, k)
        for i in 0..<k {
            arr2.append(arr1[i])
        }
        return arr2
    }
    func getKLitter(_ arr:inout [Int],_ leftIndex:Int,_ rightIndex:Int, _ k: Int){
        let m = quickArr(&arr, leftIndex, rightIndex)
        if m<k-1 {
          getKLitter(&arr, m+1, rightIndex, k)
        }else if m>k-1{
            getKLitter(&arr, leftIndex, m-1, k)
        }else{
            return
        }
        
    }
    func quickArr(_ arr:inout [Int],_ leftIndex:Int,_ rightIndex:Int)->Int{
//        if leftIndex>=rightIndex {
//            return
//        }
        let key = arr[leftIndex]
        var leftIndex1 = leftIndex
        var rightIndex1 = rightIndex
        while leftIndex1 < rightIndex1 {
            while leftIndex1 < rightIndex1 && arr[rightIndex1]>=key {
                rightIndex1 -= 1
            }
            if arr[rightIndex1] < key {
                arr.swapAt(rightIndex1, leftIndex1)
            }
            while leftIndex1<rightIndex1 && arr[leftIndex1]<=key {
                leftIndex1+=1
            }
            if arr[leftIndex1]>key {
                arr.swapAt(leftIndex1, rightIndex1)
            }
        }
        return leftIndex1
//        quickArr(&arr, leftIndex, leftIndex1-1)
//        quickArr(&arr, leftIndex1+1, rightIndex)
    }
    func isBalanced(_ root: TreeNode?) -> Bool
    {
        guard root != nil else {
            return true
        }
        var queue = [TreeNode]()
        queue.append(root!)
        var hight = 0
        var low = 0
        while !queue.isEmpty {
            
            for _ in 0..<queue.count {
                let first = queue.removeFirst()
                if first === root  {
                    if first.right == nil || first.left == nil {
                        low = 1
                    }
                }
                if first.left == nil && first.right == nil {
                    if low == 0 {
                        low = hight + 1
                    }
                    continue
                }
                if first.left != nil {
                    queue.append(first.left!)
                }
                if first.right != nil {
                    queue.append((first.right!))
                }
            }
            hight += 1
        }
        return hight - low > 1 ? false : true
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let sweq = findRepeatNumber([2, 3, 1, 0, 2, 5, 3])
        let root = TreeNode.init(1)
//        root.left = TreeNode.init(2)
        root.right = TreeNode.init(2)
//        root.left?.left = TreeNode.init(3)
        root.right?.right = TreeNode.init(3)
//        root.left?.left?.left = TreeNode.init(7)
//        root.left?.left?.right = TreeNode.init(2)
//        root.right?.left = TreeNode.init((13))
//        root.right?.right = TreeNode.init(4)
//        root.right?.right?.right = TreeNode.init(1)
        let hasPathS = isBalanced(root)
        var rsult1 = getLeastNumbers([3,4,2,1,0,3], 5)
        let root1 = TreeNode.init(3)
        root1.left = TreeNode.init(9)
        root1.right = TreeNode.init(20)
        root1.right?.left = TreeNode.init((15))
        root1.right?.right = TreeNode.init(7)
        invertTree(root1)
        return true
    }
    //4.翻转二叉树
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard root != nil else {
            return root
        }
        var rootNode = root
        let leftNode = invertTree(root?.left)
        let rightNode = invertTree(root?.right)
        return root
        
    }
  

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

