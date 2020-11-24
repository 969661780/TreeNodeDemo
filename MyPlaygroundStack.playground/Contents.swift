import UIKit
public class TreeNode{
    public var left : TreeNode?
    public var right : TreeNode?
    public var val : Int
    public init(_ val : Int){
        self.val = val
        self.left = nil
        self.right = nil
    }
}
public class ListNode{
    public var next : ListNode?
    public var val : Int
    public init(_ val:Int){
        self.val = val
        self.next = nil
    }
}
var str = "Hello, playground"

func isValid(_ s: String) -> Bool {
    var stack:[String] = []
    let paren_map = [")":"(","]":"[","}":"{"]
    for char in s {
        if paren_map.values.contains(char.description) {
            stack.append(char.description)
        }else if paren_map[char.description] != stack.popLast(){
            return false
        }
    }
    return stack.count == 0
}
isValid("([)]")
//中序遍历
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
//最小的k个数
func getLeastNumbers(_ arr: [Int], _ k: Int) -> [Int] {
    if arr.isEmpty || k == 0 {
        return []
    }
    let leftIndex = 0
    let rightIndex = arr.count - 1
    var arr1 = arr
    var arr2 : [Int] = []
    getLitter(&arr1, leftIndex, rightIndex, k)
    for i in 0..<k {
        arr2.append(arr1[i])
    }
    return arr2
}
func getLitter(_ arr:inout [Int],_ leftIndex:Int,_ rightIndex:Int,_ k:Int){
    let m = quickArr(&arr, leftIndex, rightIndex)
    if m<k-1 {
        getLitter(&arr, m+1, rightIndex, k)
    }else if m>k-1{
        getLitter(&arr, leftIndex, m-1, k)
    }
    return
}
func quickArr(_ arr:inout [Int],_ leftIndex:Int,_ rightIndex:Int) ->Int
{
    let key = arr[leftIndex]
    var leftI = leftIndex
    var rightI = rightIndex
    while leftI < rightI {
        while leftI < rightI && arr[rightI]>=key {
            rightI -= 1
        }
        if arr[rightI] < key {
            arr.swapAt(rightI, leftI)
        }
        while leftI < rightI && arr[leftI]<=key {
            leftI += 1
        }
        if arr[leftI]>key {
            arr.swapAt(leftI, rightI)
        }
        
    }
    return leftI
}

let least = getLeastNumbers([0,1,3,2], 2)


//heap
//合并K个升序链表
func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    let count = lists.count
    guard count != 0 else {
        return nil
    }
    return mege(lists, 0, count-1)
}
func mege(_ lists:[ListNode?], _ left:Int,_ right:Int) -> ListNode?
{
    if left == right {
       return lists[left]
    }
    let mid  = left + (right - left)/2
    let l = mege(lists, left, mid)
    let m = mege(lists, mid+1, right)
    return megreTwoList(l, m)
}
func megreTwoList(_ left:ListNode?,_ right:ListNode?) -> ListNode?
{
    var l1 = left
    var l2 = right
    guard left != nil else {
        return right
    }
    guard right != nil else {
        return left
    }
    let preNode = ListNode.init(0)
    var pre = preNode
    while l1 != nil && l2 != nil {
        if l1!.val > l2!.val  {
            pre.next = l2
            l2 = l2?.next
        }else{
            pre.next = l1
            l1 = l1?.next
        }
        pre = pre.next!
    }
    pre.next = l1?.val == nil ? l2 : l1
    return preNode.next
}
