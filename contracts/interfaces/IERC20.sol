pragma solidity ^0.4.24;

/**
 * @title Interface for contracts conforming to ERC-20
 */
contract ERC20Interface {
  function transferFrom(address from, address to, uint tokens) public returns (bool success);
}
