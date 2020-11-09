import UIKit
public class ListNode{
    public var val:Int
    public var next:ListNode?
    public init(_ val:Int){
        self.val = val
        self.next = nil
    }
}
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
var str = "Hello, playground"
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
}
let sweq = findRepeatNumber([2, 3, 1, 0, 2, 5, 3])
func getKthFromEnd(_ head: ListNode?, _ k: Int) -> ListNode?
{
    var lowHead = head
    var fastHead = head
    for _ in 0..<k {
        fastHead = fastHead?.next
    }
    while fastHead != nil {
        fastHead = fastHead?.next
        lowHead = lowHead?.next
    }
   return lowHead
}
var listNode = ListNode.init(1)
listNode.next = ListNode.init(2)
listNode.next?.next = ListNode.init(3)
listNode.next?.next?.next = ListNode.init(4)
listNode.next?.next?.next?.next = ListNode.init(5)
var resultNode = getKthFromEnd(listNode, 2)

func getLeastNumbers(_ arr: [Int], _ k: Int) -> [Int] {
    let leftIndex = 0
    let rightIndex = arr.count - 1
    var arr1 = arr
    var arr2 = [Int]()
    quickArr(&arr1, leftIndex, rightIndex)
    for i in 0..<k {
        arr2.append(arr1[i])
    }
    return arr2
}
func quickArr(_ arr:inout [Int],_ leftIndex:Int,_ rightIndex:Int){
    if leftIndex>=rightIndex {
        return
    }
    let key = arr[leftIndex]
    var leftIndex = leftIndex
    var rightIndex = rightIndex
    while leftIndex < rightIndex {
        while leftIndex < rightIndex && arr[rightIndex]>=key {
            rightIndex -= 1
        }
        if arr[rightIndex] < key {
            arr.swapAt(rightIndex, leftIndex)
        }
        while leftIndex<rightIndex && arr[leftIndex]<=key {
            leftIndex+=1
        }
        if arr[leftIndex]>key {
            arr.swapAt(leftIndex, rightIndex)
        }
    }
    quickArr(&arr, leftIndex, rightIndex)
}
var rsult1 = getLeastNumbers([0,1,2,1], 2)
//最小深度
func minDepth(_ root: TreeNode?) -> Int {
    guard let node = root else {
        return 0
    }
    if node.left == nil && node.right == nil {
        return 1
    }
    var deep = Int.max
    if node.left != nil {
        deep = min(deep, minDepth(node.left))
    }
    if node.right != nil {
        deep = min(deep, minDepth(node.right))
    }
    return deep + 1
}
func minDepth1(_ root: TreeNode?) -> Int {
    if root == nil {
        return 0
    }
    var queue = [TreeNode]()
    queue.append(root!)
    var deep = 0
    while !queue.isEmpty {
        for _ in 0..<queue.count {
            let first = queue.removeFirst()
            if first.left == nil && first.right == nil {
                return deep + 1
            }
            if first.left != nil {
                queue.append(first.left!)
            }
            if first.right != nil {
                queue.append(first.right!)
            }
        }
        deep += 1
    }
    return 0
}
//最大深度
func maxDepth(_ root: TreeNode?) -> Int {
    guard  root != nil else {
        return 0
    }
    return max(maxDepth(root?.left) , maxDepth(root?.right))+1
}
func maxDepth1(_ root: TreeNode?) -> Int{
    guard root != nil else {
        return 0
    }
    var  queue = [TreeNode]()
    queue.append(root!)
    var deep = 0
    while !queue.isEmpty {
        for _ in 0..<queue.count {
            let first = queue.removeFirst()
            if first.left != nil {
                queue.append(first.left!)
            }
            if first.right != nil {
                queue.append(first.right!)
            }
        }
        deep += 1
    }
    return deep
}

let root = TreeNode.init(3)
root.left = TreeNode.init(9)
root.right = TreeNode.init(20)
root.right?.left = TreeNode.init((15))
root.right?.right = TreeNode.init(7)

let mindeep = maxDepth(root)
//路径总和
func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool
{
    guard root != nil else {
        return false
    }
    var queue = [TreeNode]()
    queue.append(root!)
    while !queue.isEmpty {
        for _ in 0..<queue.count {
            let first = queue.removeFirst()
            if first.left == nil && first.right == nil {
                if first.val == sum  {
                    return true
                }
                continue
            }

            if first.left != nil {
                first.left?.val += first.val
                queue.append(first.left!)
            }
            if first.right != nil {
                first.right?.val += first.val
                queue.append(first.right!)
            }
        }
    }
    return false
}
func hasPathSum1(_ root: TreeNode?, _ sum: Int) -> Bool
{
    guard root != nil else {
        return false
    }
    if root?.val == sum && root?.left == nil && root?.right == nil {
        return true
    }
    return hasPathSum1(root?.left, sum - root!.val) || hasPathSum1(root?.right, sum - root!.val)
}
let hasPathS = hasPathSum(root, 11)
let hsPS = hasPathSum1(root, 11)


//验证树类型
//1.对称二叉树
func isSymmetric(_ root: TreeNode?) -> Bool
{
    guard root != nil else {
        return true
    }
   return check(root?.left,root?.right)
}
func check(_ left:TreeNode?,_ right:TreeNode?) -> Bool
{
    if left == nil && right == nil {
        return true
    }
    if left?.val != right?.val {
        return false
    }
    return check(left?.left, right?.right) && check(left?.right, right?.left)
}
//2.平衡二叉树
func isBalanced(_ root: TreeNode?) -> Bool
{
    if root == nil {
        return true
    }
    if abs(height(root?.left) - height(root?.right)) <= 1 && isBalanced(root?.left)
        && isBalanced(root?.right){
        return true
    }
    return false
}
func height(_ node:TreeNode?)->Int
{
    if node == nil {
        return 0
    }
    return max(height(node?.left), height(node?.right))+1
}
//3.相同的树
func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
    if p == nil && q == nil {
        return true
    }
    return p?.val == q?.val && isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
}

