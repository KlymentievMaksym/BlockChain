// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {CAVE} from "../src/CAVE.sol";

/**
 * $ forge script script/DeployCAVE.s.sol:DeployCAVE --rpc-url $SEPOLIA_RPC_URL --broadcast --chain sepolia -vvvv
 * $ forge verify-contract <CAVE_CONTRACT_ADDRESS> src/CAVE.sol:CAVE --chain sepolia --etherscan-api-key $ETHERSCAN_API_KEY
 */
contract DeployCAVE is Script
{
    function run() public returns (CAVE)
    {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        vm.startBroadcast(deployerPrivateKey);
        
        CAVE cave = new CAVE();
        
        console.log("CAVE Token deployed at:", address(cave));
        console.log("Deployer (Admin):", deployer);
        
        vm.stopBroadcast();
        
        return cave;
    }
}