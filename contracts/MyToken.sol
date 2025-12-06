// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    // --- Token Details ---
    string public name = "MyToken";        // Token Name
    string public symbol = "MTK";          // Token Symbol
    uint8 public decimals = 18;            // Decimals (Standard: 18)
    uint256 public totalSupply;            // Total supply variable

    // Mapping to track balances of each address
    mapping(address => uint256) public balanceOf;

    // Mapping for allowances (owner => spender => amount)
    mapping(address => mapping(address => uint256)) public allowance;

        // --- Events ---
    // Emitted when tokens are transferred between addresses
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Emitted when an approval is set
    event Approval(address indexed owner, address indexed spender, uint256 value);


    // Constructor: Executes only once when deployed
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;          // Set total supply
        balanceOf[msg.sender] = _initialSupply; // Assign all tokens to deployer
    }

        // --- Transfer Tokens ---
    // Allows the sender to transfer tokens to another address
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Cannot transfer to zero address");   // Prevent sending to 0x0
        require(balanceOf[msg.sender] >= _value, "Insufficient balance"); // Check balance

        balanceOf[msg.sender] -= _value;  // Remove tokens from sender
        balanceOf[_to] += _value;         // Add tokens to receiver

        emit Transfer(msg.sender, _to, _value); // Emit event

        return true;
    }

        // --- Approve Spender ---
    // Allows the token owner to approve another address to spend tokens
    function approve(address _spender, uint256 _value) public returns (bool success) {
        require(_spender != address(0), "Cannot approve zero address"); // Prevent invalid approvals

        allowance[msg.sender][_spender] = _value; // Set the allowance amount

        emit Approval(msg.sender, _spender, _value); // Emit event

        return true;
    }

        // --- Transfer From ---
    // Allows a spender to transfer tokens from an owner to another address
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Cannot transfer to zero address");        // Prevent sending to 0x0
        require(balanceOf[_from] >= _value, "Insufficient balance");          // Check owner's balance
        require(allowance[_from][msg.sender] >= _value, "Insufficient allowance"); // Check allowance

        balanceOf[_from] -= _value;     // Deduct from owner's balance
        balanceOf[_to] += _value;       // Add to recipient's balance
        allowance[_from][msg.sender] -= _value; // Reduce the allowance

        emit Transfer(_from, _to, _value); // Emit transfer event

        return true;
    }



}
