//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {MerkleAirDrop} from "../src/MerkleAirdrop.sol";
import {MerkoraToken} from "../src/MerkoraToken.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script {
    
    bytes32 private s_merkleRoot=0xa21d4feb017d02176f34357f58a1746b764ef71ad40cb3a6480b7cd587abd3a9;
    uint256 private s_amountToTransfer = 4 * 25 *1e18;

    function deployMerkleAirdrop() public returns(MerkleAirDrop,MerkoraToken) {
    vm.startBroadcast();
    MerkoraToken token= new MerkoraToken();
    MerkleAirDrop airdrop=new MerkleAirDrop(s_merkleRoot,IERC20(address(token)));
    token.mint(token.owner(),s_amountToTransfer);
    token.transfer(address(airdrop),s_amountToTransfer);
    vm.stopBroadcast();
    return (airdrop,token);
    }

    function run() external returns(MerkleAirDrop,MerkoraToken) {
        return deployMerkleAirdrop();
    }
}