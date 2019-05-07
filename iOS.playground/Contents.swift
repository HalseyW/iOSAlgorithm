//栈
class Stack {
    var stack: [AnyObject]
    var isEmpty: Bool {
        return stack.isEmpty
    }
    var peek: AnyObject? {
        return stack.last
    }
    
    init() {
        stack = [AnyObject]()
    }
    
    func push(object: AnyObject) {
        stack.append(object)
    }
    
    func pop() -> AnyObject? {
        if isEmpty {
            return nil
        } else {
            return stack.removeLast()
        }
    }
}

//给定一个整型数组和一个目标值，返回这个数组中是否有两个值相加等于目标值
func twoSum(nums: [Int], target: Int) -> Bool {
    var set = Set<Int>()
    for num in nums {
        if set.contains(target - num) {
            return true
        }
        set.insert(num)
    }
    return false
}

//给定一个整型数组和一个目标值，判断这个数组中是否有两个值相加等于目标值，如果有，这返回两个值的下标
func twoSumDic(nums: [Int], target: Int) -> [Int] {
    var dict = [Int: Int]()
    for (i, num) in nums.enumerated() {
        if let index = dict[target - num] {
            return [index ,i]
        } else {
            dict[num] = i
        }
    }
    fatalError("no valid value")
}

//给定一个 String，将这个 String 中的单词倒装过来
func _swap<T>(char: inout [T], p: Int, q: Int) {
    (char[p], char[q]) = (char[q], char[p])
}

func _reverse<T>(char: inout [T], start: Int, end: Int) {
    var start = start, end = end
    while start < end {
        _swap(char: &char, p: start, q: end)
        start += 1
        end -= 1
    }
}

func reverseWords(s: String) -> String {
    var chars = Array(s), start = 0
    _reverse(char: &chars, start: 0, end: chars.count - 1)
    for i in 0 ..< chars.count {
        if i == chars.count - 1 || chars[i + 1] == " " {
            _reverse(char: &chars, start: start, end: i)
            start = i + 2
        }
    }
    return String(chars)
}

//链表节点
class ListNode {
    var val: Int
    var next: ListNode?

    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

//链表
class List {
    var head: ListNode?
    var tail: ListNode?

    //尾插法
    func appendToTail(_ val: Int) {
        if tail == nil {
            tail = ListNode(val)
            head = tail
        } else {
            tail!.next = ListNode(val)
            tail = tail!.next
        }
    }

    //头插法
    func appendToHead(_ val: Int) {
        if head == nil {
            head = ListNode(val)
            tail = head
        } else {
            let temp = ListNode(val)
            temp.next = head
            head = temp
        }
    }
}

//给定一个链表和一个目标值，将链表中小于目标值的节点移到左边，大于等于的节点移到右边
func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
    let prevDummy = ListNode(0), postDummy = ListNode(0)
    var prev = prevDummy, post = postDummy
    var node = head

    while node != nil {
        if node!.val < x {
            prev.next = node
            prev = node!
        } else {
            post.next = node
            print(postDummy.next?.val)
            post = node!
        }
        node = node!.next
    }

    post.next = nil
    prev.next = postDummy.next

    return prevDummy.next
}

//判断链表是否有循环
func hasCycle(head: ListNode?) -> Bool {
    var slow = head
    var fast = head
    while slow?.next != nil && fast?.next != nil {
        slow = slow!.next
        fast = fast!.next!.next
        if slow === fast {
            return true
        }
    }
    return false
}
