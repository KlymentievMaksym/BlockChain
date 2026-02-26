// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {CAVE} from "../src/CAVE.sol";

contract CAVETest is Test
{
    CAVE public cave;
    address public user1;
    address public user2;

    function setUp() public
    {
        cave = new CAVE();
        user1 = address(0x1);
        user2 = address(0x2);
    }

    function test_InitialState() public view
    {
        assertEq(cave.name(), "CAVE token, created for lab in Institute of Physics and Technology");
        assertEq(cave.symbol(), "CAVE-2026");
        assertEq(cave.decimals(), 18);
        assertEq(cave.totalSupply(), 10_000 * 10 ** 18);
        assertEq(cave.balanceOf(address(this)), 10_000 * 10 ** 18);
    }
}