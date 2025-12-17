//SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {MerkleAirDrop} from "../src/MerkleAirdrop.sol";
import {MerkoraToken} from "../src/MerkoraToken.sol";
import {ZkSyncChainChecker} from "lib/foundry-devops/src/ZkSyncChainChecker.sol";
import {DeployMerkleAirdrop} from "../script/MerkleAirdrop.s.sol";

contract MerkleAirdropTest is ZkSyncChainChecker,Test {
    MerkleAirDrop public airdrop;
    MerkoraToken public token;
    address user; //In the merkle tree
    uint256 userPrivateKey;
    uint256 public AMOUNT_TO_CLAIM = 25 * 1e18;
    uint256 AMOUNT_TO_MINT = AMOUNT_TO_CLAIM*5;
    address public gasPayer;
    bytes32 private proofOne=0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a;
    bytes32 private proofTwo=0x03409387063d91e8151d58d66d544711e79dac0a0041408dbc73f8b39d94e446;
    bytes32[] public PROOF = [proofOne,proofTwo];
    bytes32 public ROOT = 0xa21d4feb017d02176f34357f58a1746b764ef71ad40cb3a6480b7cd587abd3a9;

    function setUp() public {
        if(!isZkSyncChain()){
            DeployMerkleAirdrop deployer = new DeployMerkleAirdrop();
            (airdrop,token) = deployer.deployMerkleAirdrop();
        } else {
        token = new MerkoraToken();
        airdrop = new MerkleAirDrop(ROOT, token);
        token.mint(token.owner(),AMOUNT_TO_MINT);
        token.transfer(address(airdrop),AMOUNT_TO_MINT);
        }
        gasPayer = makeAddr("gasPayer");
        (user, userPrivateKey) = makeAddrAndKey("user");
    }

    function testUsersCanClaim() public {
        uint256 startingBalance = token.balanceOf(user);
        bytes32 digest = airdrop.getMessageHash(user,AMOUNT_TO_CLAIM);
        // vm.prank(user);
        //Sign the message by user
        (uint8 v,bytes32 r, bytes32 s) = vm.sign(userPrivateKey,digest);

        //gasPayer calls claim using the signed message
        vm.prank(gasPayer);
        airdrop.claim(user, AMOUNT_TO_CLAIM, PROOF,v,r,s);
        uint256 endingBalance=token.balanceOf(user);
        console.log("Ending Balnce: ",endingBalance);
        assertEq(endingBalance-startingBalance,AMOUNT_TO_CLAIM);
    }
}
