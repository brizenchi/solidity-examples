// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ArrayShift {
    uint[] public arr;
    
    // 清空数组中某个字段
    function example() public {
        arr = [1,2,3];
        delete arr[1];// 1, 0, 3
    }

    // 移除数组中某个下标
    function remove(uint _index) public {
        require(_index < arr.length, "index out of bound");
        for (uint i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i+1];
        }
        arr.pop();
    }

    // 不在意顺序，为了节约gas费，把最后一个挪到前面
    function remove2(uint _index) public {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }
}