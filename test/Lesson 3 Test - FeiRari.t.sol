// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Lesson 3 - FeiRari.sol";
import "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract FeiRariExploit is Test {
    BalancerInterface public balancerFlashLoanContract;

    function setUp() public {
        vm.startPrank(address(0x7));
        vm.rollFork(14684371);

        balancerFlashLoanContract = BalancerInterface(payable(0xBA12222222228d8Ba445958a75a0704d566BF2C8));
    }

    function testExploitRari() public {
        // console.log("hey");
        address[] memory path = new address[](1);
        path[0] = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 1;
        bytes memory userData = "";

        balancerFlashLoanContract.flashLoan(address(0x7), path, amounts, userData);
    }

    // function receiveFlashLoan(
    //     IERC20[] memory tokens,
    //     uint256[] memory amounts,
    //     uint256[] memory feeAmounts,
    //     bytes memory userData
    // ) external override {
    //     require(msg.sender == vault);
    // }
}
