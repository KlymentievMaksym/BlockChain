// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";

import {CAVE} from "../src/CAVE.sol";
import {CAVEFaucet} from "../src/CAVEFaucet.sol";


contract CAVEFaucetTest is Test
{
    CAVE public cave;
    CAVEFaucet public caveFaucet;
    address public user1;

    uint256 constant PRECISION = 10 ** 18;
    uint256 constant TIME_LIMIT = 60;

    function setUp() public
    {
        cave = new CAVE();
        caveFaucet = new CAVEFaucet(address(cave));
        user1 = address(0x1);

        cave.setFaucet(address(caveFaucet));
        cave.mint(address(caveFaucet), 10 * PRECISION);
    }

    function test_claim() public
    {
        assertEq(cave.balanceOf(address(caveFaucet)), 10 * PRECISION);
        vm.prank(user1);
        caveFaucet.claim();
        assertEq(cave.balanceOf(address(caveFaucet)), 0);
        assertEq(cave.balanceOf(user1), 10 * PRECISION);
    }

    function test_claimWithCooldown() public
    {
        vm.prank(user1);
        caveFaucet.claim();
        assertEq(cave.balanceOf(user1), 10 * PRECISION);

        vm.prank(user1);
        vm.expectRevert(bytes("Wait 1 minute"));
        caveFaucet.claim();

        vm.warp(block.timestamp + TIME_LIMIT);

        vm.prank(user1);
        caveFaucet.claim();
        assertEq(cave.balanceOf(user1), 20 * PRECISION);
    }
}