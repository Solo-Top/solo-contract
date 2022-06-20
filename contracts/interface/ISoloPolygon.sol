// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

/**
 * ------------------------ Solo Polygon Pools ------------------------
 *
 * Contract address: 0xE95876787B055f1b9E4cfd5d3e32BDe302BF789d
 *
 * Reward Token: WMATIC
 * Fee Token: USDC
 *
 * Pools (pid => token):
 *  0 => WBTC (0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6)
 *  1 => WETH (0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619)
 *  2 => WMATIC (0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270)
 *  3 => QUICK (0x831753DD7087CaC61aB5644b308642cc1c33Dc13)
 *  4 => USDT (0xc2132D05D31c914a87C6611C10748AEb04B58e8F)
 *  5 => USDC (0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174)
 *  6 => DAI (0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063)
 *
 */

interface ISoloPolygon {

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