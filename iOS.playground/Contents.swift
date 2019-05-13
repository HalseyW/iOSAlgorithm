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

//删除链表中倒数第N个节点, n小于链表长度
func removeNthFromEnd(head: ListNode?, _ n: Int) -> ListNode? {
    guard let head = head else { return nil }
    let dummy = ListNode(0)
    dummy.next = head
    var prev: ListNode? = dummy
    var post: ListNode? = dummy
    
    for _ in 0 ..< n {
        if post == nil {
            break
        }
        post = post!.next
    }
    
    while post != nil, post!.next != nil {
        prev = prev!.next
        post = post!.next
    }
    
    prev!.next = prev!.next?.next
    
    return dummy.next
}

//栈
protocol Stack {
    //持有的元素类型
    associatedtype Element
    //栈是否为空
    var isEmpty: Bool { get }
    //栈的大小
    var size: Int { get }
    //栈顶元素
    var peek: Element? { get }
    //入栈
    mutating func push(_ newElement: Element)
    //出栈
    mutating func pop() -> Element?
}

struct IntegerStack: Stack {
    typealias Element = Int
    private var stack = [Element]()
    
    var isEmpty: Bool { return stack.isEmpty }
    var size: Int { return stack.count }
    var peek: Int? { return stack.last }
    
    mutating func push(_ newElement: Int) {
        stack.append(newElement)
    }
    
    mutating func pop() -> Int? {
        return stack.popLast()
    }
}

//队列
protocol Queue {
    //队列元素类型
    associatedtype Element
    //是否为空
    var isEmpty: Bool { get }
    //队列大小
    var size: Int { get }
    //队首元素
    var peek: Element? { get }
    //入列
    mutating func enqueue(_ newElement: Element)
    //出列
    mutating func dequeue() -> Element?
}

struct IntegerQueue: Queue {
    typealias Element = Int
    private var left = [Element]()
    private var right = [Element]()
    
    var isEmpty: Bool { return left.isEmpty && right.isEmpty }
    var size: Int { return left.count + right.count }
    var peek: Int? { return left.isEmpty ? right.first : left.last }
    
    mutating func enqueue(_ newElement: Int) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Int? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

//简化路径
func simplyfyPath(path: String) -> String {
    var pathStack = [Substring]()
    let paths = path.split(separator: "/")
    
    for path in paths {
        guard path != "." else {
            continue
        }
        if path == ".." {
            if pathStack.count > 0 {
                pathStack.removeLast()
            }
        } else if path != "" {
            pathStack.append(path)
        }
    }
    let res = pathStack.reduce("") { total, dir in "\(total)/\(dir)"}
    
    return res.isEmpty ? "/" : res
}

//使用栈实现队列
class MyQueue {
    var stackA: IntegerStack
    var stackB: IntegerStack
    var isEmpty: Bool { return stackA.isEmpty && stackB.isEmpty }
    var size: Int { return stackA.size + stackB.size }
    var peek: Int? {
        get {
            shift()
            return stackB.peek
        }
    }
    
    init() {
        stackA = IntegerStack()
        stackB = IntegerStack()
    }
    
    func enqueue(_ newElement: Int) {
        stackA.push(newElement)
    }
    
    func dequeue() -> Int? {
        shift()
        return stackB.pop()
    }
    
    func shift() {
        if stackB.isEmpty {
            while !stackA.isEmpty {
                stackB.push(stackA.pop()!)
            }
        }
    }
}

//使用队列实现栈
class MyStack {
    var queueA: IntegerQueue
    var queueB: IntegerQueue
    var isEmpty: Bool {
        return queueA.isEmpty && queueB.isEmpty
    }
    var size: Int {
        return queueA.size + queueB.size
    }
    var peek: Int? {
        get {
            shift()
            let peekObj = queueA.peek
            queueB.enqueue(queueA.dequeue()!)
            return peekObj
        }
    }
    
    init() {
        queueA = IntegerQueue()
        queueB = IntegerQueue()
    }
    
    func push(_ newElement: Int) {
        queueA.enqueue(newElement)
    }
    
    func pop() -> Int? {
        shift()
        let pop = queueA.dequeue()
        swap()
        return pop
    }
    
    func swap() {
        (queueA, queueB) = (queueB, queueA)
    }
    
    func shift() {
        while queueA.size != 1 {
            queueB.enqueue(queueA.dequeue()!)
        }
    }
}

//二叉树
public class ThreeNode {
    public var val: Int
    public var left: ThreeNode?
    public var right: ThreeNode?
    init(_ val: Int) {
        self.val = val
    }
}

//计算二叉树的最大深度
func maxDepth(root: ThreeNode?) -> Int {
    guard let root = root else {
        return 0
    }
    return max(maxDepth(root: root.left), maxDepth(root: root.right)) + 1
}

//判断一棵树为二叉查找树
func isValidBST(root: ThreeNode?) -> Bool {
    return _helper(node: root, nil, nil)
}

func _helper(node: ThreeNode?, _ min: Int?, _ max: Int?) -> Bool {
    guard let node = node else {
        return true
    }
    //右子节点的值必须大于父节点的值
    if let min = min, node.val <= min {
        return false
    }
    //左子节点的值必须小于父节点的值
    if let max = max, node.val >= max {
        return false
    }
    return _helper(node: node.left, min, node.val) && _helper(node: node.right, node.val, max)
}

//二叉树前序遍历
func preorderTraversal(root: ThreeNode?) -> [Int] {
    var res = [Int]()
    var stack = [ThreeNode]()
    var node = root
    
    while !stack.isEmpty || node != nil {
        if node != nil {
            res.append(node!.val)
            stack.append(node!)
            node = node!.left
        } else {
            node = stack.removeLast().right
        }
    }
    
    return res
}

//使用队列实现二叉树层级遍历
func levelOrder(root: ThreeNode?) -> [[Int]] {
    var res = [[Int]]()
    var queue = [ThreeNode]()
    
    if let root = root {
        queue.append(root)
    }
    
    while queue.count > 0 {
        var level = [Int]()
        let size = queue.count
        
        for _ in 0 ..< size {
            let node = queue.removeFirst()
            
            level.append(node.val)
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        res.append(level)
    }
    
    return res
}

//归并排序
func mergeSort(_ array: [Int]) -> [Int] {
    var helper = Array(repeating: 0, count: array.count), array = array
    mergeSort(&array, &helper, 0, array.count - 1)
    return array
}

func mergeSort(_ array: inout [Int], _ helper: inout [Int], _ low: Int, _ high: Int) {
    guard low < high else {
        return
    }
    let middle = (high - low) / 2 + low
    mergeSort(&array, &helper, low, middle)
    mergeSort(&array, &helper, middle + 1, high)
    merge(&array, &helper, low, middle, high)
}

func merge(_ array: inout [Int], _ helper: inout [Int], _ low: Int, _ middle: Int, _ high: Int) {
    for i in low ... high {
        helper[i] = array[i]
    }
    
    var helplerLeft = low, helperRight = middle + 1, current = low
    
    while helplerLeft <= middle && helperRight <= high {
        if helper[helplerLeft] <= helper[helperRight] {
            array[current] = helper[helplerLeft]
            helplerLeft += 1
        } else {
            array[current] = helper[helperRight]
            helperRight += 1
        }
        current += 1
    }
    
    guard middle - helplerLeft >= 0 else {
        return
    }
    for i in 0 ... middle - helplerLeft {
        array[current + i] = helper[helplerLeft + i]
    }
}

//快速排序
func quickSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else {
        return array
    }
    
    let pivot = array[array.count / 2]
    let left = array.filter { $0 < pivot }
    let middle = array.filter { $0 == pivot }
    let right = array.filter { $0 > pivot }
    
    return quickSort(left) + middle + quickSort(right)
}

//二分搜索
func binarySerch(_ nums: [Int], _ target: Int) -> Bool {
    var left = 0, mid = 0, right = nums.count - 1
    
    while left <= right {
        mid = (right - left) / 2 + left
        if nums[mid] == target {
            return true
        } else if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    
    return false
}

//递归实现二分搜索
func binarySerchByRecursive(nums: [Int], target: Int) -> Bool {
    return binarySerchByRecursive(nums: nums, target: target, left: 0, right: nums.count - 1)
}

func binarySerchByRecursive(nums: [Int], target: Int, left: Int, right: Int) -> Bool {
    guard left <= right else {
        return false
    }
    
    let mid = (right - left) / 2 + left
    
    if nums[mid] == target {
        return true
    } else if nums[mid] < target {
        return binarySerchByRecursive(nums: nums, target: target, left: mid + 1, right: right)
    } else {
        return binarySerchByRecursive(nums: nums, target: target, left: left, right: mid - 1)
    }
}
