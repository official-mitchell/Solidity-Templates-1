// truffle migration
module.exports = function (deployer, network, accounts) {
    const startTime = web3.eth.getBlock('latest').timestamp + 60; // 1 min in the future
    const endTime = startTime + 86400 * 20; // 20 days
    const rate = new web3.BigNumber(2000);
    const wallet = accounts[9];
    const goal = new web3.BigNumber(4000000000000000000000);
    const cap = new web3.BigNumber(50000000000000000000000);

    return deployer
        .then(() => {
            return deployer.deploy(MyToken);
        })
        .then(() => {
            return deployer.deploy(
                MyCrowdsale,
                startTime,
                endTime,
                rate,
                wallet,
                goal,
                cap,
                MyToken.address
            );
        });
};


// test js

it('one ETH should buy 2000 tokens', function (done) {
    MyCrowdsale.deployed().then(async function (instance) {
        const data = await instance.sendTransaction({from: accounts[7], value: web3.toWei(1, "ether")});
    //..
        done();
    });
});

//** Test throws Uncaught Error: VM Exception while processing transaction: revert **//

// my contract constructor
function MyCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet, uint256 _goal, uint256 _cap, MintableToken _token) public

Crowdsale(_rate, _wallet, _token)
CappedCrowdsale(_cap)
TimedCrowdsale(_startTime, _endTime)
RefundableCrowdsale(_goal)

{
    require(_goal <= _cap);
}
// overrode buyTokens function to try and isolate the problem ….
function buyTokens(address _beneficiary) public payable {

    BuyTokens(_beneficiary, msg.value, goal, cap, rate);

    uint256 weiAmount = msg.value;
    _preValidatePurchase(_beneficiary, weiAmount);

    // calculate token amount to be created
    uint256 tokens = _getTokenAmount(weiAmount);

    // update state
    weiRaised = weiRaised.add(weiAmount);

    _processPurchase(_beneficiary, tokens);
   // ...
}
// overrode  _preValidatePurchase and pulled all the required forward from the inherited contracts to get it to work
function _preValidatePurchase(address _beneficiary, uint256 _weiAmount) internal {

    require(_beneficiary != address(0));
    require(_weiAmount != 0);
    require(weiRaised.add(_weiAmount) <= cap);
}
