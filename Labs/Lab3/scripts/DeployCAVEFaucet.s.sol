// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {CAVEFaucet} from "../src/CAVEFaucet.sol";

/**
 * $ forge script scripts/DeployCAVEFaucet.s.sol:DeployCAVEFaucet --rpc-url $SEPOLIA_RPC_URL --broadcast --chain sepolia -vvvv
 * $ forge verify-contract <CAVE_CONTRACT_ADDRESS> src/CAVEFaucet.sol:CAVEFaucet --chain sepolia --etherscan-api-key $ETHERSCAN_API_KEY
 */
contract DeployCAVEFaucet is Script
{
    function run() public returns (CAVEFaucet)
    {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        address caveToken = vm.envAddress("CAVE_TOKEN_ADDRESS");
        
        vm.startBroadcast(deployerPrivateKey);
        
        CAVEFaucet caveFaucet = new CAVEFaucet(caveToken);
        
        console.log("CAVE token address used:", caveToken);
        console.log("CAVE Faucet deployed at:", address(caveFaucet));
        console.log("Deployer (Admin):", deployer);
        
        vm.stopBroadcast();
        
        return caveFaucet;
    }
}