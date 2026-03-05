// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import {IAccessControl} from "@openzeppelin/contracts/access/IAccessControl.sol";

import {KMA} from "../src/KMA.sol";

contract KMATest is Test, IERC721Receiver
{
    KMA public kma;
    address public user1;
    address public user2;

    function onERC721Received(address, address, uint256, bytes calldata) external pure override returns (bytes4)
    {
        return IERC721Receiver.onERC721Received.selector;
    }

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
    }

    function test_Mint() public
    {
        uint256 picId = kma.createPic("ipfs://bafkreierayyyuv3wqjs4bplqlertcyn7umiorvripu6fb66i6anmy44ehu");
        assertEq(kma.ownerOf(picId), address(this));
        assertEq(kma.balanceOf(address(this)), 1);
    }

    function test_MintToUserCreate() public
    {
        uint256 picId = kma.createPic(user1, "ipfs://bafkreierayyyuv3wqjs4bplqlertcyn7umiorvripu6fb66i6anmy44ehu");
        assertEq(kma.ownerOf(picId), user1);
    }

    function test_MintToUserTransfer() public
    {
        uint256 picId = kma.createPic("ipfs://bafkreierayyyuv3wqjs4bplqlertcyn7umiorvripu6fb66i6anmy44ehu");
        kma.safeTransferFrom(address(this), user1, picId);
        assertEq(kma.ownerOf(picId), user1);
    }

    function test_Creator() public
    {
        kma.setCreator(user1);
    
        vm.prank(user1);
        uint256 picId = kma.createPic("ipfs://bafkreierayyyuv3wqjs4bplqlertcyn7umiorvripu6fb66i6anmy44ehu");
    
        assertEq(kma.ownerOf(picId), user1);
    }

    function test_CreatorDelete() public
    {
        kma.setCreator(user1);
    
        vm.prank(user1);
        kma.createPic("ipfs://bafkreierayyyuv3wqjs4bplqlertcyn7umiorvripu6fb66i6anmy44ehu");

        kma.deleteCreator(user1);
        vm.expectRevert(bytes("No permission"));
        vm.prank(user1);
        kma.createPic("ipfs://bafkreierayyyuv3wqjs4bplqlertcyn7umiorvripu6fb66i6anmy44ehu");
    }

    function test_CreatorWrong() public
    {
        vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user1, kma.OWNER_ROLE()));
        vm.prank(user1);
        kma.setCreator(user1);
    }

    function test_CreatorNFTTransfer() public
    {
        kma.setCreator(user1);
    
        vm.prank(user1);
        uint256 picId = kma.createPic("ipfs://bafkreierayyyuv3wqjs4bplqlertcyn7umiorvripu6fb66i6anmy44ehu");
        vm.prank(user1);
        kma.safeTransferFrom(user1, user2, picId);
    
        assertEq(kma.ownerOf(picId), user2);
    }
}