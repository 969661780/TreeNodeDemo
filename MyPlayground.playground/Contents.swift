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
//4.翻转二叉树
func invertTree(_ root: TreeNode?) -> TreeNode? {
    guard root != nil else {
        return root
    }
    let rootNode = root
    let leftNode = invertTree(rootNode?.left)
    let rightNode = invertTree(rootNode?.right)
    rootNode?.left = rightNode
    rootNode?.right = leftNode
    return rootNode
    
}
let root1 = TreeNode.init(3)
root1.left = TreeNode.init(9)
root1.right = TreeNode.init(20)
root1.right?.left = TreeNode.init((15))
root1.right?.right = TreeNode.init(7)
invertTree(root1)
//左叶子节点之和
func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
    guard root != nil else {
        return 0
    }
    var queue = [TreeNode]()
    queue.append(root!)
    var sum = 0
    while !queue.isEmpty {
        for _ in 0..<queue.count {
            let first = queue.removeFirst()
            if first.left != nil {
                if !(first.left?.left == nil && first.left?.right == nil) {
                    queue.append(first.left!)
                }else{
                    sum += first.left!.val
                }
                
            }
            if first.right != nil {
                if !(first.right?.left == nil && first.right?.right == nil) {
                    queue.append(first.right!)
                }
               
            }
        }
    }
    return sum
}
func sumOfLeftLeaves1(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    var ans = 0
    if let l = root.left, l.left == nil && l.right == nil {
        ans += l.val
    }
    ans += sumOfLeftLeaves(root.left)
    ans += sumOfLeftLeaves(root.right)
    return ans
}
//二叉搜索树的最近公共节点
func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode?
{
    guard root != nil else {
        return root
    }
    if root!.val<p!.val && root!.val<q!.val {
        lowestCommonAncestor(root?.right, p, q)
    }else if root!.val>p!.val && root!.val > q!.val{
        lowestCommonAncestor(root?.left, p, q)
    }
    return root
}
func lowestCommonAncestor1(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode?
{
    if root == nil || root === p || root === q {
        return root
    }
    let left = lowestCommonAncestor1(root?.left, p, q)
    let right = lowestCommonAncestor1(root?.right, p, q)
 
    if left == nil {
        return right
    }
    if right == nil {
        return left
    }
    return root
}
//二叉树的层次遍历
func levelOrderBottom(_ root: TreeNode?) -> [[Int]]
{
    guard root != nil else {
        return []
    }
    var queue = [TreeNode]()
    queue.append(root!)
    var resultArr = [[Int]]()
    while !queue.isEmpty {
        var arr = [Int]()
        for _ in 0..<queue.count {
            let first = queue.removeFirst()
            arr.append(first.val)
            if first.left != nil {
                queue.append(first.left!)
            }
            if first.right != nil {
                queue.append(first.right!)
            }
        }
        resultArr.insert(arr, at: 0)
    }
    return resultArr
}
//将有序数组转换为二叉搜索树
func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
  return  DFS(nums, 0, nums.count - 1)
}
func DFS(_ nums:[Int],_ low:Int,_ height:Int) ->TreeNode?
{
    if low>height {
        return nil
    }
    let mid = (height - low)/2 + low
    let treeNode = TreeNode.init(nums[mid])
    treeNode.left = DFS(nums, low, mid-1)
    treeNode.right = DFS(nums, mid+1, height)
    return treeNode
}
//二叉树中序遍历
func inorderTraversal(_ root: TreeNode?) -> [Int] {
    guard root != nil else {
        return []
    }
    var resultArr = [Int]()
    if root?.left != nil {
        resultArr += inorderTraversal(root?.left)
    }
    resultArr.append(root!.val)
    if root?.right != nil {
        resultArr += inorderTraversal(root?.right)
    }
    return resultArr
}
//二叉树转换为链表
func flatten(_ root: TreeNode?) {
    guard root != nil else {
        return
    }
    var rootArr = [TreeNode]()
    midTr(root!, &rootArr)
    for i in 1..<rootArr.count {
        let node1 = rootArr[i]
        let node2 = rootArr[i-1]
        node2.left = nil
        node2.right = node1
    }
}
func midTr(_ root:TreeNode,_ arr:inout [TreeNode])
{
    arr.append(root)
    if root.left != nil {
        midTr(root.left!, &arr)
    }
    if root.right != nil {
        midTr(root.right!, &arr)
    }
}
//不同的二叉搜索树:卡特兰树
func numTrees(_ n: Int) -> Int {
    guard n>1 else {
        return 1
    }
    var num = Array.init(repeating: 1, count: n+1)
    for i in 2...n {
        for j in 0...i-1 {
            num[i] += num[j]*num[i-j-1]
        }
    }
    return num[n]
}
numTrees(2)
//验证二叉搜索树
func isValidBST(_ root: TreeNode?) -> Bool {
    return inorder(root)
}
var preNode : TreeNode?
func inorder(_ root:TreeNode?) -> Bool {
    guard let root = root else {
        return true
    }
    if inorder(root.left) == false {
        return false
    }
    if preNode != nil && preNode!.val >= root.val {
        return false
    }
    preNode = root
    
    return inorder(root.right)
}
