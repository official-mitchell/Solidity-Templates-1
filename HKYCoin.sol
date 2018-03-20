pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/ownership/HasNoEther.sol";
import "zeppelin-solidity/contracts/crowdsale/CappedCrowdsale.sol";
import "zeppelin-solidity/contracts/token/ERC20/MintableToken.sol";


contract HUIToken is MintableToken, HasNoEther {
  string public constant name = "HKY Token";
  string public constant symbol = "HKY";
  uint8 public constant decimals = 18;

  address public crowdSale;

  function setCrowdSale(address _crowdSale) public onlyOwner {
    crowdSale = _crowdSale;
  }

  function mint(address _to, uint256 _amount) canMint public returns (bool) {
    require(msg.sender == owner || msg.sender == crowdSale);

    totalSupply_ = totalSupply_.add(_amount);
    balances[_to] = balances[_to].add(_amount);
    Mint(_to, _amount);
    Transfer(address(0), _to, _amount);
    return true;
  }

}

contract HKYCrowdsale is CappedCrowdsale {

  function HKYCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet, MintableToken _token) public
    CappedCrowdsale(36000 ether)
    Crowdsale(_startTime, _endTime, _rate, _wallet, _token)
  {
  }
}
