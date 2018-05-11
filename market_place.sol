pragma solidity ^0.4.21;


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
    if (a == 0) {
      return 0;
    }
    c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    // uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return a / b;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
    c = a + b;
    assert(c >= a);
    return c;
  }
}


// Basic EC model contract
contract MarketPlace{

  using SafeMath for uint;

  address public owner;
  uint public price;
  uint public quantity;

  event Price(uint _price);
  event Buy(address _addr,uint _price, uint _quantity, uint _stock);

  // constructor
  function MarketPlace() public{
    owner = msg.sender;
    price = 100;
    quantity = 1000;
  }

  // modifer only Owner
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  // to update price
  function changePrice(uint _price) public onlyOwner() {
    price = _price;

    emit Price(_price);
  }

  // to buy
  function buy(uint _quantity) public payable{
    require(quantity > 0 && _quantity > 0);

    if(msg.value > _quantity.mul(price)){
      quantity = quantity.sub(_quantity);

      msg.sender.transfer(msg.value.sub(_quantity.mul(price)));
    }

    emit Buy(msg.sender, price, _quantity, quantity);
  }


}
