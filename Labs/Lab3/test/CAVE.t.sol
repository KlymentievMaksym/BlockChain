// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {IAccessControl} from "@openzeppelin/contracts/access/IAccessControl.sol";
import {CAVE} from "../src/CAVE.sol";

contract CAVETest is Test
{
    CAVE public cave;
    address public user1;
    address public user2;

    uint256 constant PRECISION = 10 ** 18;

    function setUp() public
    {
        cave = new CAVE();
        user1 = address(0x1);
        user2 = address(0x2);
    }

    function test_InitialState() public view
    {
        assertEq(cave.name(), "Klymentiev Maksym Andriyovych Token");
        assertEq(cave.symbol(), "CAVE-2026");
        assertEq(cave.totalSupply(), 10_000 * PRECISION);
        assertEq(cave.balanceOf(address(this)), 10_000 * PRECISION);
    }

    function test_Claim() public
    {
        vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user1, cave.OWNER_ROLE()));
        vm.prank(user1);
        cave.claim(20 * PRECISION);
    }

    function test_ClaimOwner() public
    {
        cave.claim(20 * PRECISION);
        assertEq(cave.balanceOf(address(this)), 10_020 * PRECISION);
    }

    function test_Mint() public
    {
        vm.prank(user1);
        vm.expectRevert(bytes("No permission"));
        cave.mint(user1, 20 * PRECISION);
    }

    function test_MintOwner() public
    {
        cave.mint(user1, 20 * PRECISION);
        assertEq(cave.balanceOf(user1), 20 * PRECISION);
    }

    function test_Transfer() public
    {
        cave.transfer(user1, 20 * PRECISION);
        assertEq(cave.balanceOf(user1), 20 * PRECISION);
    }

    function test_TransferLessThanMax() public
    {
        cave.transfer(user1, 20 * PRECISION);

        vm.prank(user1);
        cave.transfer(user2, 10 * PRECISION);
    
        assertEq(cave.balanceOf(user1), 10 * PRECISION);
        assertEq(cave.balanceOf(user2), 10 * PRECISION);
    }

    function test_TransferMoreThanMax() public
    {
        cave.transfer(user1, 25 * PRECISION);

        vm.prank(user1);
        vm.expectRevert(bytes("Transfer exceeds 25 tokens"));
        cave.transfer(user2, 30 * PRECISION);
    }

    function test_TransferMoreThanMaxOwner() public
    {
        cave.transfer(user1, 50 * PRECISION);
        assertEq(cave.balanceOf(user1), 50 * PRECISION);
    }
}