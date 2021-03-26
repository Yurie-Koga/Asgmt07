//
//  roadTravel.swift
//  Graph2
//
//  Created by Uji Saori on 2021-03-25.
//

import Foundation

// input
/*
8 2
5 2
0 1
0 2
2 3
4 3
6 1
1 5
7 3

*/
// output
// 3


// input
/*
8 5
0 6 4 3 7
0 1
0 2
2 3
4 3
6 1
1 5
7 3

 */
// outout
// 7
func tour() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]
    let m = input[1]
    
    let mElements = readLine()!.split(separator: " ").map { Int($0)! }
    
    var adj = [[Int]](repeating: [Int](), count: n)
    for _ in 0 ..< n - 1 {
        let edge = readLine()!.split(separator: " ").map { Int($0)! }
        let u = edge[0]
        let v = edge[1]
        adj[u].append(v)
        adj[v].append(u)
    }
    print("===== Each Node =====")
    for i in 0 ..< adj.count {
        print("<\(i)> \(adj[i])")
    }
    print("m elements: \(mElements)")
    
    var dis = 0
    var min = -1
    var check = [Bool](repeating: false, count: m)
    for i in 0 ..< m {
        check = [Bool](repeating: false, count: m)  // reset
        check[i] = true
        // node starts from 0 -> start preNodeIndex from -1
        roadDis(tree: adj, mElements: mElements, stNodeIndex: mElements[i], preNodeIndex: -1, disSofar: &dis, minDis: &min, check: &check)
        
    }
    print(min)
}

func roadDis(tree: [[Int]], mElements: [Int], stNodeIndex: Int, preNodeIndex: Int, disSofar: inout Int, minDis: inout Int, check: inout [Bool]) {
    let curNodes = tree[stNodeIndex]
    for i in 0 ..< curNodes.count {
        if !check.contains(false) {
            if minDis == -1 || minDis > disSofar { minDis = disSofar }
            break
        }
        
        let connectedNode = curNodes[i]
        if connectedNode == preNodeIndex { continue }
        
        if mElements.contains(connectedNode) {
            let ind = mElements.firstIndex(of: connectedNode)!
            if check[ind] { continue }  // already visited
            check[ind] = true
        }
  
        disSofar += 1
        roadDis(tree: tree, mElements: mElements, stNodeIndex: connectedNode, preNodeIndex: stNodeIndex, disSofar: &disSofar, minDis: &minDis, check: &check)
    }
}
