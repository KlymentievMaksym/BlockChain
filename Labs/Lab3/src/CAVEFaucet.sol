// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface ICAVE
{
    function transfer(address to, uint256 amount) external returns (bool);
    function mint(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract CAVEFaucet
{
    ICAVE public cave;
    uint256 public amount = 10 * 10 ** 18;

    mapping(address => uint256) public lastClaim;

    constructor(address caveAddress)
    {
        cave = ICAVE(caveAddress);
    }

    function claim() public
    {
        if (lastClaim[msg.sender] != 0)
        {
            require(block.timestamp - lastClaim[msg.sender] >= 1 minutes, "Wait 1 minute");
        }
        lastClaim[msg.sender] = block.timestamp;
        if (cave.balanceOf(address(this)) >= amount)
        {
            require(cave.transfer(msg.sender, amount), "Transfer failed");
        }
        else
        {
            require(cave.mint(msg.sender, amount), "Mint failed");
        }
    }
}