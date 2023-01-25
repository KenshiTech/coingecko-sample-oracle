// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Price {
    uint256 private _price;
    address private _owner;
    address private _oracle;

    constructor() {
        _owner = msg.sender;
    }

    /**
     * Sets the oracle address to prevent anyone else from
     * calling the "setPrice" method
     */
    function setOracle(address oracle) external {
        require(msg.sender == _owner, "Only owner can call this");
        _oracle = oracle;
    }

    // A simple event to make price data requests
    event PriceRequest();

    /**
     * Emit and event that will be picked up by the Kenshi
     * Oracle Network and sent to your oracle for processing
     */
    function requestPrice() external {
        emit PriceRequest();
    }

    /**
     * This method will be called by the Kenshi Oracle Network
     * with the result returned from your oracle
     */
    function setPrice(uint256 price) external {
        require(msg.sender == _oracle, "Only oracle can call this");
        _price = price;
    }

    /**
     * This function simply returns the price set by the oracle
     */
    function getPrice() external view returns (uint256) {
        return _price;
    }
}
