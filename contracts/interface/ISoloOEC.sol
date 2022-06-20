// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

/**
 * ------------------------ Solo OEC Pools ------------------------
 *
 * Contract address: 0xa8AF3199aCE72E47c1DEb56E58BEA1CD41C37c22
 *
 * Reward Token: CHE
 * Fee Token: USDT
 *
 * Pools (pid => token):
 *  0 => CHE (0x8179D97Eb6488860d816e3EcAFE694a4153F216c)
 *  1 => USDT (0x382bB369d343125BfB2117af9c149795C6C65C50)
 *  2 => WOKT (0x8F8526dbfd6E38E3D8307702cA8469Bae6C56C15)
 *  3 => OKB (0xdF54B6c6195EA4d948D03bfD818D365cf175cFC2)
 *  4 => BTCK (0x54e4622DC504176b3BB432dCCAf504569699a7fF)
 *  5 => ETHK (0xEF71CA2EE68F45B9Ad6F72fbdb33d707b872315C)
 *  6 => JF (0x5fAc926Bf1e638944BB16fb5B787B5bA4BC85b0A)
 *  7 => TPT (0x2ceC1C3f71Db54C99D6df687d8AC968cCe80CC85)
 */

interface ISoloOEC {

    /**
     * @dev Get Pool infos
     * If you want to get the pool's available quota, let "avail = depositCap - accShare"
     */
    function pools(uint256 pid) external view returns (
        address token,              // Address of token contract
        uint256 depositCap,         // Max deposit amount
        uint256 depositClosed,      // Deposit closed
        uint256 accShare,           // Accumulated Share/Amount
        uint256 usedShare,          // Used Share/Amount for mining
        // -------- Reward --------
        uint256 lastRewardBlock,    // Last block number that reward distributed
        uint256 accRewardPerShare,  // Accumulated rewards per share
        uint256 aprReward,          // APR of Reward, times 10000
        // ---------- Fee ---------
        uint256 lastFeeBlock,       // Last block number that fee distributed
        uint256 accFeePerShare,     // Accumulated fees per share
        uint256 aprFee              // APR of Fee, times 10000
    );

    /**
    * @dev Get pid of given token
    */
    function pidOfToken(address token) external view returns (uint256 pid);

    /**
    * @dev Get User infos
    */
    function users(uint256 pid, address user) external view returns (
        uint256 amount,     // How many tokens the user has deposited
        uint256 rewardDebt, // Reward debt, reward has been paid so far, Ignore
        uint256 feeDebt     // Fee debt, fee has been paid so far, Ignore
    );

    /**
     * @dev Get user unclaimed reward & fee
     */
    function unclaimedReward(uint256 pid, address user) external view returns (uint256 reward, uint256 fee);

    /**
     * @dev How much is the reward (USDT) equals to token1 and token2?
     */
    function rewardEquals(uint256 amountUsdt) external view returns (uint256 amount1, uint256 amount2);

    /**
     * @dev Get user total claimed reward & fee of all pools
     */
    function userStatistics(address user) external view returns (uint256 claimedReward, uint256 claimedFee);

    /**
     * @dev Deposit tokens and Claim reward & fee
     * If you just want to claim reward & fee, call function: "deposit(pid, 0)"
     */
    function deposit(uint256 pid, uint256 amount) external;

    /**
     * @dev Withdraw tokens
     */
    function withdraw(uint256 pid, uint256 amount) external;

}