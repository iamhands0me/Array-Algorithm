/*
 
 var myInts = [10, 20, 30, 30, 20, 10, 10, 20]   // 10 20 30 30 20 10 10 20
 myInts.sort()                                   // 10 10 10 20 20 20 30 30

 let low = myInts.lowerBound(of: 20)             //          ^
 let up = myInts.upperBound(of: 20)              //                   ^

 if myInts.binarySearch(of: 20) {
     print("found!")
 }
 
 */

extension Array where Element: Comparable {
    func lowerBound(_ subrange: Range<Int>? = nil,
                    of element: Element,
                    by areInIncreasingOrder: (Element, Element) -> Bool = (<)) -> Self.Index {
        var l = subrange?.lowerBound ?? self.startIndex
        var r = (subrange?.upperBound ?? self.endIndex) - 1
        while l <= r {
            let mid = (l + r) / 2
            if areInIncreasingOrder(self[mid], element) {
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
        return l
    }
    
    func upperBound(_ subrange: Range<Int>? = nil,
                    of element: Element,
                    by areInIncreasingOrder: (Element, Element) -> Bool = (<)) -> Self.Index {
        var l = subrange?.lowerBound ?? self.startIndex
        var r = (subrange?.upperBound ?? self.endIndex) - 1
        while l <= r {
            let mid = (l + r) / 2
            if !areInIncreasingOrder(element, self[mid]) {
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
        return l
    }
    
    func binarySearch(_ subrange: Range<Int>? = nil,
                      of element: Element,
                      by areInIncreasingOrder: (Element, Element) -> Bool = (<)) -> Bool {
        let subrange = subrange ?? self.startIndex ..< self.endIndex
        let startIndex = lowerBound(subrange, of: element, by: areInIncreasingOrder)
        return startIndex != subrange.upperBound && !areInIncreasingOrder(element, self[startIndex])
    }
}
