//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MerkleAirDrop} from "../src/MerkleAirdrop.sol";

contract ClaimAirdrop is Script {
    error ClaimAirdrop__InvalidSignatureLength();

    address CLAIMING_ADDRESS = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        uint256 CLAIMING_AMOUNT = 25 * 1e18;
        bytes32 proofOne=0xd1445c931158119b00449ffcac3c947d028c0c359c34a6646d95962b3b55c6ad;
        bytes32 proofTwo=0x03409387063d91e8151d58d66d544711e79dac0a0041408dbc73f8b39d94e446;
        bytes32[] proof =[proofOne,proofTwo];
        bytes private SIGNATURE = hex"fbd2270e6f23fb5fe9248480c0f4be8a4e9bd77c3ad0b1333cc60b5debc511602a2a06c24085d8d7c038bad84edc53664c8ce0346caeaa3570afec0e61144dc11c";
    
    function claimAirdrop(address airdrop) public {
        
   
        vm.startBroadcast();
         (uint8 v,bytes32 r, bytes32 s) = splitSignature(SIGNATURE);
        MerkleAirDrop(airdrop).claim(CLAIMING_ADDRESS,CLAIMING_AMOUNT,proof,v,r,s);
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("MerkleAirDrop",block.chainid);
        claimAirdrop(mostRecentlyDeployed);
    }

    function splitSignature(bytes memory sig) public returns(uint8 v, bytes32 r, bytes32 s) {
    if(sig.length!=65){
        revert ClaimAirdrop__InvalidSignatureLength();
    }
    assembly {
        r := mload(add(sig,32))
        s := mload(add(sig,64))
        v:= byte(0, mload(add(sig,96)))
    }
    }
}
