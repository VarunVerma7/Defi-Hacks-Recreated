pragma solidity ^0.8.4;
// SPDX-License-Identifier: AGPL-3.0-or-later

import "forge-std/Test.sol";

import "openzeppelin-contracts/access/Ownable.sol";
import "openzeppelin-contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/token/ERC20/utils/SafeERC20.sol";

/**
 * Based on synthetix BaseRewardPool.sol & convex cvxLocker
 * Modified for use by TempleDAO
 */

interface StaxLPStaking {
    function DURATION() external view returns (uint256);
    function addReward(address _rewardToken) external;
    function balanceOf(address account) external view returns (uint256);
    function claimableRewards(address, address) external view returns (uint256);
    function earned(address _account, address _rewardsToken) external view returns (uint256);
    function getReward(address staker, address rewardToken) external;
    function getRewards(address staker) external;
    function migrateStake(address oldStaking, uint256 amount) external;
    function migrateWithdraw(address staker, uint256 amount) external;
    function migrator() external view returns (address);
    function notifyRewardAmount(address _rewardsToken, uint256 _amount) external;
    function owner() external view returns (address);
    function renounceOwnership() external;
    function rewardData(address)
        external
        view
        returns (uint40 periodFinish, uint216 rewardRate, uint40 lastUpdateTime, uint216 rewardPerTokenStored);
    function rewardDistributor() external view returns (address);
    function rewardPerToken(address _rewardsToken) external view returns (uint256);
    function rewardPeriodFinish(address _token) external view returns (uint40);
    function rewardTokens(uint256) external view returns (address);
    function setMigrator(address _migrator) external;
    function setRewardDistributor(address _distributor) external;
    function stake(uint256 _amount) external;
    function stakeAll() external;
    function stakeFor(address _for, uint256 _amount) external;
    function stakingToken() external view returns (address);
    function totalSupply() external view returns (uint256);
    function transferOwnership(address newOwner) external;
    function userRewardPerTokenPaid(address, address) external view returns (uint256);
    function withdraw(uint256 amount, bool claim) external;
    function withdrawAll(bool claim) external;
}

contract Hackor {
    constructor() {}
    function migrateWithdraw(address oldStaking, uint256 amount) public {}
}
