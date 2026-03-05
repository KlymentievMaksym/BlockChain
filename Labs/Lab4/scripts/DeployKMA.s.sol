// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {KMA} from "../src/KMA.sol";

/**
 * $ forge script scripts/DeployKMA.s.sol:DeployKMA --rpc-url $SEPOLIA_RPC_URL --broadcast --chain sepolia -vvvv
 * $ forge verify-contract <CAVE_CONTRACT_ADDRESS> src/KMA.sol:KMA --chain sepolia --etherscan-api-key $ETHERSCAN_API_KEY
 */
contract DeployKMA is Script
{
    function run() public returns (KMA)
    {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        vm.startBroadcast(deployerPrivateKey);
        
        KMA cave = new KMA();
        
        console.log("KMA Token deployed at:", address(cave));
        console.log("Deployer (Admin):", deployer);
        
        vm.stopBroadcast();
        
        return cave;
    }
}