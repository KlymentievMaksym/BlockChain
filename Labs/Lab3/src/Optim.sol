// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.8.2 <0.9.0;
// contact implements some math and string functions 
// just for fun ;)
contract Optim
{
    int128 public x = 1;
    int128 public z = 1;

    // uint8 j = 1; 

    int256 public y = 1;
    
    string public s = "Hello World";
    
    uint256[] public data;
    uint256[] public sender;
    
    // hash value of "s" is 706a14243bdfb6cd9ceac069d364a81fd2718453631b30b3c0be8458bd641471
    // bytes32 public hash = keccak256(abi.encodePacked(s));
    bytes32 public hash = 0x706a14243bdfb6cd9ceac069d364a81fd2718453631b30b3c0be8458bd641471;

    function getNumber() view external returns (int256)
    {
        return y;
    }
    function getNumber2() view external returns (int128)
    {
        return x+z;
    }
    function addNumber(uint256 number) external  //public
    {
        data.push(number);
    }
    function MakeArr () external  //public returns(uint256)
    { 
        for(uint256 i = 0;i < 10;)
        {
            sender.push(i);
            unchecked{i++;}
        }
    }

    function PrintHash() external view returns (bytes32)
    {
        return hash;
    }    

    function ChangeStr(string calldata str) external //memory //public
    {
        s = str;
    }


    // if (n == 0)
    // {
    //     return 1;
    // }
    // return n * factorial(n - 1);
    function factorial(uint256 n) external pure returns (uint256)  //public
    {
        uint256 result = 1;
        for (uint256 i=1; i <= n;)
        {
            result *= i;
            unchecked{i++;}
        }
        return result;
    }
}
