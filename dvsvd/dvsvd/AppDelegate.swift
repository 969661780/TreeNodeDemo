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
public class ListNode{
    public var val:Int?
    public var next:ListNode?
    public init(_ val:Int){
        self.next = nil
        self.val = val
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
    func generate(_ numRows: Int) -> [[Int]] {
        guard numRows != 0 else {
            return []
        }
        var reslutArr = [[Int]]()
        let first = [1]
        getResultArr(first, &reslutArr, numRows)
        return reslutArr
    }
    func getResultArr(_ firstArr:[Int],_ resultArr:inout [[Int]],_ numRows:Int)
    {
        if resultArr.count == numRows {
            return
        }
        var nextArr = [Int]()
        for i in 0...firstArr.count {
            var curResult = 1
            if i != 0 && i != firstArr.count {
                curResult = firstArr[i] + firstArr[i-1]
            }else{
                curResult = 1
            }
            nextArr.append(curResult)
        }
        resultArr.append(nextArr)
        getResultArr(nextArr, &resultArr, numRows)
    }
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var index1 = 0
        var index2 = 0
        if m == 0 {
            nums1 = nums2
            return
        }
        while index2<n {
            if nums1[index1] <= nums2[index2] {
                if index1 >= m + index2{
                    nums1[index1] = nums2[index2]
                    index2 += 1
                }
                index1 += 1
            }else{
                nums1.insert(nums2[index2], at: index1)
                index1 += 1
                index2 += 1
            }
        }
    }
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let nums = nums.sorted()
        var resultTaget = 10000
        for i in 0..<nums.count {
            let nowTaget = target - nums[i]
            var left = i + 1
            var right = nums.count - 1
            if right <= left {
                break
            }
            while left < right {
                if nums[left] + nums[right] == nowTaget {
                    return target
                }
                let nowTaget1 = nums[i] + nums[left] + nums[right]
                if abs(nowTaget1 - target) < abs(resultTaget - target) {
                    resultTaget = nowTaget1
                }
                if nums[left] + nums[right] < nowTaget {
                    left += 1
                }
                if nums[left] + nums[right] > nowTaget {
                       right -= 1
                }
            }
        }
        return resultTaget
    }
//    func reverseList(_ head: ListNode?) -> ListNode? {
//        guard head != nil else {
//            return head
//        }
//        var headNode : ListNode? = nil
//        var nowNode = head
//        while nowNode != nil {
//            let runNode = nowNode?.next
//            nowNode?.next = headNode
//            headNode = nowNode
//            nowNode = runNode
//        }
//        return headNode
//    }
 
    func swapPairs(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        let resultNode = head?.next
        var nowHead1 = ListNode.init(0)
        nowHead1.next = head
        while nowHead1.next != nil {
            let a = nowHead1.next
            let b = a!.next
            a?.next = b?.next
            b?.next = a
            nowHead1.next = b
            nowHead1 = a!
        }
        return resultNode
    }
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var n = n
        var head1 = head
        var head2 = head
        while head1?.next != nil {
            while n > 0 {
                head1 = head1?.next
                n-=1
            }
            head1 = head1?.next
            head2 = head2?.next
        }
        head2?.next = head2?.next?.next
        return head
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let sweq = findRepeatNumber([2, 3, 1, 0, 2, 5, 3])
//        var listNode1 = ListNode.init(1)
//        listNode1.next = ListNode.init(2)
//        listNode1.next?.next = ListNode.init(3)
//        reverseList(listNode1)
        
        var head = ListNode.init(1)
        head.next = ListNode.init(2)
        head.next?.next = ListNode.init(3)
        head.next?.next?.next = ListNode.init(4)
        head.next?.next?.next?.next = ListNode.init(5)
        let reResultNode = removeNthFromEnd(head, 2)
        
        var ewqe = [1,2,3,0,0,0]
        var adad = [2,5,6]
        merge(&ewqe, 3, adad, 3)
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
//        invertTree(root1)
        let dwdqa =  inorderTraversal(root1)
        let qeqe = generate(5)
        
        findRepeatNumber1([2, 3, 1, 0, 0, 5, 6])
        var asd = [0,1,0,3,12]
        moveZeroes1(&asd)
        
        let resultArr = combinationSum([2,3,6,7], 7)
        
        let wsda = threeSumClosest([-1,2,1,-4], 1)
        
        return true
        
    }
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var list1 = l1
        var list2 = l2
        let  result = ListNode.init(0)
        var result1 = result
        var addResult = 0
        while list1 != nil || list2 != nil {
            let result =  (list1?.val ?? 0) + (list2?.val ?? 0) + addResult
            addResult = result/10
            result1.next = ListNode.init(result%10)
            list2 = list2?.next
            list1 = list1?.next
            result1 = result1.next!
        }
        if addResult>0 {
            result1.next = ListNode.init(addResult)
        }
        return result.next
    }
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        if candidates.count == 0 {
            return []
        }
        var resultArr = [[Int]]()
        var targetArr = [Int]()
        getResultSum(candidates.sorted(), target, 0, &resultArr, &targetArr)
        return resultArr
    }
    func getResultSum(_ candidates: [Int], _ target: Int,_ start:Int,_ resutArr: inout[[Int]],_ targetArr:inout[Int])
    {
        if target < 0 {
            return
        }
        if target == 0 {
            resutArr.append(targetArr)
            return
        }
        for i in start..<candidates.count {
            if target - candidates[i] < 0 {
                break
            }
            let nowNum = candidates[i]
            targetArr.append(nowNum)
            getResultSum(candidates, target-nowNum, i, &resutArr, &targetArr)
            targetArr.removeLast()
        }
    }
    func moveZeroes1(_ nums: inout [Int]) {
        var i = 0
        for j in 0..<nums.count {
            if nums[j] != 0 {
                nums.swapAt(i, j)
                i += 1
            }
        }
    }
    func findRepeatNumber1(_ nums: [Int]) -> Int {

        guard nums.count != 0 else {
            return -1
        }
        var hash = [Int:Int]()
        for i in 0..<nums.count {
            if hash.keys.contains(nums[i]) {
                return i
            }
            hash[nums[i]] = 1
        }
        return -1
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
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var stack : [TreeNode] = []
        var result : [Int] = []
        var node : TreeNode? = root
        while node != nil || !stack.isEmpty {
            while node != nil {
                stack.append(node!)
                node = node?.left
            }
            node = stack.popLast()
            result.append(node!.val)
            node = node?.right
        }
        return result
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

