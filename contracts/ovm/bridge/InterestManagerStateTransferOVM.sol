// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "./interfaces/IInterestManagerStateTransferOVM.sol";
import "../core/InterestManagerBaseOVM.sol";

/**
 * @title InterestManagerStateTransferOVM
 * @author Alexander Schlindwein
 *
 * Replaces the L2 InterestManager logic for the state transfer from L1.
 * This implementation will also not invest anything into Compound or similar,
 * and will remain the logic until Compound has moved to L2.
 */
contract InterestManagerStateTransferOVM is InterestManagerBaseOVM, IInterestManagerStateTransferOVM {

    /**
     * Initializes the contract. 
     *
     * @param owner The owner (IdeaTokenExchange)
     * @param dai The address of the Dai contract
     */
    function initializeStateTransfer(address owner, address dai) external override {
        require(address(_dai) == address(0), "already-init");
        initializeBaseInternal(owner, dai);
    }

    /**
     * Increments the _totalShares. Used for state transfer.
     * Can only be called by the IdeaTokenExchange.
     *
     * @param amount The amount by which to increase _totalShares
     */
    function addToTotalShares(uint amount) external override onlyOwner {
        _totalShares = _totalShares.add(amount);
    }

    /**
     * Invest an amount of Dai. Does nothing for now.
     *
     * @param amount The amount of Dai to invest
     */
    function investInternal(uint amount) internal override {}

    /**
     * Redeems an amount of Dai. Does nothing for now.
     *
     * @param amount The amount of Dai to redeem
     */
    function redeemInternal(address recipient, uint amount) internal override {}

    /**
     * Accrues interest. Does nothing for now.
     */
    function accrueInterest() external override {}

    /**
     * Returns the total amount of Dai holdings.
     *
     * @return The total amount of Dai holdings.
     */
    function getTotalDaiReserves() public view override returns (uint) {
        return _dai.balanceOf(address(this));
    }
}