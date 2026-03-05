// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {IAccessControl} from "@openzeppelin/contracts/access/IAccessControl.sol";
import {KMA} from "../src/KMA.sol";

contract KMATest is Test
{
    KMA public kma;
    address public user1;
    address public user2;

    // uint256 constant PRECISION = 10 ** 18;

    function setUp() public
    {
        kma = new KMA();
        user1 = address(0x1);
        user2 = address(0x2);
    }

    function test_InitialState() public view
    {
        assertEq(kma.name(), "Klymentiev Maksym Andriyovych");
        assertEq(kma.symbol(), "KMA");
        // assertEq(cave.totalSupply(), 10_000 * PRECISION);
        // assertEq(cave.balanceOf(address(this)), 10_000 * PRECISION);
    }
}