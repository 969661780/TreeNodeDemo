import UIKit

var str = "Hello, playground"
//判断子序列
func isSubsequence(_ s: String, _ t: String) -> Bool {
    var indexs = 0
    var indext = 0
    let arrays = Array(s)
    let arrayt = Array(t)
    while indexs < arrays.count && indext < arrayt.count {
        let chars = arrays[indexs]
        let chart = arrayt[indext]
        if chars == chart {
            indexs += 1
        }
        indext += 1
    }
    if indexs == arrays.count {
        return true
    }
    return false
}
let reallyResult = isSubsequence("abc", "ahhbddc")
//买股票
func maxProfit(_ prices: [Int]) -> Int {
    var lowPro = 0
    var heiPro = 0
    var resultPro = 0
    var i = 1
    while i<prices.count {
        while i<prices.count && prices[i] < prices[i-1] {
            i+=1
            break
        }
        lowPro = prices[i-1]
        while i<prices.count && prices[i] > prices[i-1] {
            i += 1
            break
    }
        heiPro = prices[i-1]
        resultPro += heiPro - lowPro
}
    return resultPro
}
let resultPro = maxProfit([1,2,3,4,5])


//位运算
//多数元素
func majorityElement(_ nums: [Int]) -> Int {
    var hashDic = [Int:Int]()
    let count = nums.count / 2
    for i in 0..<nums.count {
        if i<=count {
            hashDic[nums[i]] == nil ? (hashDic[nums[i]] = 1) : (hashDic[nums[i]]! += 1)
            if hashDic[nums[i]]! > count {
                return nums[i]
            }
        }else{
            if hashDic[nums[i]] != nil {
                hashDic[nums[i]]! += 1
                if hashDic[nums[i]]! > count {
                    return nums[i]
                }
            }
            continue
        }
    }
    return -1
}

//只出现了一次的元素
func singleNumber(_ nums: [Int]) -> Int {
    var a = nums[0]
    for i in 1..<nums.count {
        a = a^nums[i]
    }
    return a
}
let mmm = singleNumber([4,1,2,1,2])
//裴波那契数列
func fib(_ n: Int) -> Int {
    if n < 1 {
        return 0
    }
    var  next = 1 ,last = 0
    for _ in 1..<n {
        (last,next) = (next,last+next)
        next = next % 1000000007
    }
    return next
}


//滑动窗口
func lengthOfLongestSubstring(_ s: String) -> Int {
    if s.count == 0 {
        return 0
    }
    var resultArr = String()
    var cureeArr = String()
    for char in s {
        while cureeArr.contains(char) {
            cureeArr.remove(at: cureeArr.startIndex)
        }
        cureeArr.append(char)
        if resultArr.count < cureeArr.count {
            resultArr = cureeArr
        }
    }
    return resultArr.count
}
lengthOfLongestSubstring("abcabcbb")
