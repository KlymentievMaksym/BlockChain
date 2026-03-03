// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.8.2 <0.9.0;



contract Looop {
    uint256 i;
    function MakeLoop(uint256 n) public {
    while( i < n ) {
        i++; 
    }
    }
    function retrieve() public view returns (uint256){
        return i;
    }
}
