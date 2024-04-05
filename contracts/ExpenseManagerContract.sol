// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract ExpenseManagerContract {
    address public owner;

    struct Transaction {
        address user;
        uint amount;
        string description;
        uint timestamp;
    }

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;  // call the next modifier or function if it exists
    }

    Transaction[] public transactions;

    mapping(address => uint) public balances;

    event Deposit(
        address indexed _from,
        uint _amount,
        string _description,
        uint _timestamp
    );

    event Withdraw(
        address indexed _to,
        uint _amount,
        string _description,
        uint _timestamp
    );

    // deposit function with payable keyword means it can be called with a value
    function deposit(uint _amount, string memory _description) public payable {
        require(_amount > 0, "Amount must be greater than 0");
        balances[msg.sender] += _amount;
        transactions.push(
            Transaction(msg.sender, _amount, _description, block.timestamp)
        );
        emit Deposit(msg.sender, _amount, _description, block.timestamp);
    }

    // withdraw function with public keyword means it can be called from other contracts
    function withdraw(uint _amount, string memory _description) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        transactions.push(
            Transaction(msg.sender, _amount, _description, block.timestamp)
        );
        payable(msg.sender).transfer(_amount);
        emit Withdraw(msg.sender, _amount, _description, block.timestamp);
    }

    function getBalance(address _address) public view returns (uint) {
        // view means it can only be read
        return balances[_address];
    }

    function getTransactionCount() public view returns (uint) {
        return transactions.length;
    }

    // function getTransaction(
    //     uint _index
    // ) public view returns (address, uint, string memory, uint) {
    //     require(_index < transactions.length, "Index out of bounds");
    //     Transaction memory transaction = transactions[_index];
    //     return(
    //         transaction.user,
    //         transaction.amount,
    //         transaction.description,
    //         transaction.timestamp,
    //     );
    // }
    // we can not return List in solidity
    function getAllTransactions()
        public
        view
        returns (
            address[] memory,
            uint[] memory,
            string[] memory,
            uint[] memory
        )
    {
        address[] memory users = new address[](transactions.length);
        uint[] memory amounts = new uint[](transactions.length);
        string[] memory descriptions = new string[](transactions.length);
        uint[] memory timestamps = new uint[](transactions.length);

        for (uint i = 0; i < transactions.length; i++) {
            Transaction memory transaction = transactions[i];
            users[i] = transaction.user;
            amounts[i] = transaction.amount;
            descriptions[i] = transaction.description;
            timestamps[i] = transaction.timestamp;
        }
        return (users, amounts, descriptions, timestamps);
    }

    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
}
