import UIKit

var str = "Hello, playground"
//杨辉三角
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

//数组中重复的数字
func findRepeatNumber(_ nums: [Int]) -> Int {

    guard nums.count != 0 else {
        return -1
    }
    var hash = [Int:Int]()
    for i in 0..<nums.count {
        if hash.keys.contains(nums[i]) {
            return nums[i]
        }
        hash[nums[i]] = 1
    }
    return -1
}
//移动零
func moveZeroes(_ nums: inout [Int]) {
    var i = 0
    for j in 0..<nums.count {
        if nums[j] != 0 {
            nums.swapAt(i, j)
            i += 1
        }
    }
}
//移除元素
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    guard nums.count != 0 else {
        return 0
    }
    var leftIndex = 0
    var rightIndex = nums.count - 1
    while leftIndex<=rightIndex {
        if leftIndex == rightIndex && nums[leftIndex] == val {
            nums.remove(at: leftIndex)
            return nums.count
        }
        if nums[leftIndex] == val{
            nums.remove(at: leftIndex)
            rightIndex -= 1
        }else{
            leftIndex += 1
        }
        if nums[rightIndex] == val {
            nums.remove(at: rightIndex)
        }
        rightIndex -= 1
    }
    return nums.count
}
var nowArr = [0,1,2,2,3,0,4,2]
removeElement(&nowArr, 2)
//最大子序和
func maxSubArray(_ nums: [Int]) -> Int {
    guard nums.count != 0 else {
        return 0
    }
    var maxResult = nums[0]
    var nowResult = 0
    for i in nums {
        if nowResult > 0 {
            nowResult += i
        }else{
            nowResult = i
        }
        maxResult = max(maxResult, nowResult)
    }
    return maxResult
}
let result = maxSubArray([-2,1,-3,4,-1,2,1,-5,4])
//两数之后
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
  
    var hashmap = [Int:Int]()
    for (index,value) in nums.enumerated() {
        let remind = target - value
        if hashmap.keys.contains(remind) {
            if let remindIndex = hashmap[remind],index != remindIndex {
                return [remindIndex,index]
            }
        }
        hashmap[value] = index
    }
    return []
}
//合并两个有序数组
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
//搜索插入位置
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    guard nums.count != 0 else {
        return 0
    }
    var leftIndex = 0
    var rightIndex = nums.count - 1
    while leftIndex <= rightIndex {
        let mid = leftIndex + (rightIndex - leftIndex)/2
        if nums[mid] == target {
            return mid
        }
        if nums[leftIndex]>target {
            return leftIndex
        }
        if nums[rightIndex] < target {
            return rightIndex
        }
        if nums[mid] > target {
            rightIndex = mid - 1
        }
        if nums[mid] < target {
            leftIndex = mid + 1
        }
    }
    return 0
}
//加一
func plusOne(_ digits: [Int]) -> [Int] {
    var index = digits.count - 1
    var res = (digits[index] + 1)%10
   
    var digits = digits
    if res != 0 {
        digits[index] = res
        return digits
    }
    while index > 0 && res == 0 {
        digits[index] = 0
        index -= 1
        res = (digits[index] + 1)%10
        if res != 0 {
            digits[index] = digits[index]+1
        }
    }
    if res == 0 {
        digits.insert(1, at: 0)
    }
    return digits
}
plusOne([4,3,2,9])

//组合总和
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
    for i in start..<candidates.count - 1 {
        if target - candidates[i] < 0 {
            break
        }
        let nowNum = candidates[i]
        targetArr.append(nowNum)
        getResultSum(candidates, target-nowNum, i, &resutArr, &targetArr)
        targetArr.removeLast()
    }
}
let resultArr = combinationSum([2,3,6,7], 7)
//数组总和,只能用一个数
func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
    if candidates.count == 0 {
        return []
    }
    var resultArr = [[Int]]()
    var targetArr = [Int]()
    getResultSum1(candidates.sorted(), target, 0, &resultArr, &targetArr)
    return resultArr
}
func getResultSum1(_ candidates: [Int], _ target: Int,_ start:Int,_ resutArr: inout[[Int]],_ targetArr:inout[Int])
{
    if target < 0 {
        return
    }
    if target == 0 {
        resutArr.append(targetArr)
    }
    for i in start..<candidates.count {
        if i>start && candidates[i] == candidates[i-1] {
            continue
        }
        if target - candidates[i] < 0 {
            break
        }
        targetArr.append(candidates[i])
        getResultSum1(candidates, target-candidates[i], i+1, &resutArr, &targetArr)
        targetArr.removeLast()
    }
}
combinationSum2([10,1,2,7,6,1,5], 8)
//盛最多水的容器
func maxArea(_ height: [Int]) -> Int {
    var left = 0
    var right = height.count - 1
    var maxHeight = 0
    while left < right {
        let curHeight = min(height[left], height[right]) * (right - left)
        maxHeight = max(curHeight, maxHeight)
        if height[left] < height[right] {
            left += 1
        }else{
            right -= 1
        }
    }
    return maxHeight
}
let resultMax = maxArea([1,8,6,2,5,4,8,3,7])
//最接近的三数之和
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
threeSumClosest([-1,2,1,-4], 1)
//在排序数组中查找元素的第一个和最后一个位置
func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    guard nums.count != 0 else {
        return [-1,-1]
    }
    var left = 0
    var right = nums.count - 1
    while left<right {
        let mid = left + (right - left)/2
        if nums[mid] < target {
            left = mid + 1
        }
        if nums[mid] > target {
            right = mid - 1
        }
        if nums[mid] == target {
            var m = mid - 1
            while m>left {
                if nums[m] != target{
                    break
                }
                m -= 1
            }
            var n = mid + 1
            while n<right {
                if nums[n] != target {
                    break
                }
                n += 1
            }
            return [m + 1,n-1]
            
        }
    }
    return [-1,-1]
}
let resultSearch = searchRange([5,7,7,8,8,10], 8)
//搜索旋转排序数组
func search(_ nums: [Int], _ target: Int) -> Int
{
    guard nums.count != 0 else {
        return -1
    }
    var leftIndex = 0
    var rightIndex = nums.count - 1
    while rightIndex > leftIndex {
        let mid = leftIndex + (rightIndex - leftIndex)/2
        if nums[mid]  == target{
            return mid
        }
        if nums[mid] >= nums.first! {
            if nums[mid] < target {
                leftIndex  = mid + 1
            }else{
                if target >= nums.first! {
                    rightIndex = mid - 1
                }else{
                    leftIndex = mid + 1
                }
            }
        }else{
            if nums[mid] > target {
                rightIndex = mid - 1
            }else{
                if nums[rightIndex] < target {
                    rightIndex = mid - 1
                }else{
                    leftIndex = mid + 1
                }
            }
        }
    }
    return -1
}
