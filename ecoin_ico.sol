pragma solidity ^0.4.11;

contract ecoin_ico{
    
    // Introducing the total number of ecoin tokens available for sealed
    uint public max_ecoins = 1000000;
    
    // Introducing the USD to ecoin conversion rate 
    uint public usd_to_ecoins = 1000;
    
    // Introducing the total number of ecoins that have been bought by the investors
    uint public total_ecoins_bought = 0;
    
    // Mapping from the investor address to its equity in ecoins and USD
    mapping(address => uint) equity_ecoins;
    mapping(address => uint) equity_usd;
    
    // Checking if an investor can buy ecoins 
    modifier can_buy_ecoins(uint usd_invested) {
        require(usd_invested * usd_to_ecoins + total_ecoins_bought <= max_ecoins);
        _;
    }
    
    // Getting the equity in ecoins of an investor
    function equity_in_ecoins(address investor) external constant returns(uint){
        return equity_ecoins[investor];
    }
    
    
    // Getting the equity in USD of an investor
       function equity_in_usd(address investor) external constant returns(uint){
        return equity_usd[investor];
    }
    
    //Buy ecoins
    function buy_ecoins(address investor ,uint usd_invested) external
     can_buy_ecoins(usd_invested)
    {
       uint ecoins_bought = usd_invested * usd_to_ecoins;
        equity_ecoins[investor] += ecoins_bought;
        equity_usd[investor] =  equity_ecoins[investor] / 1000;
        total_ecoins_bought += ecoins_bought;
    }
    
    // Selling ecoin 
    function sell_ecoins(address investor,uint ecoins_sold) external{
        equity_ecoins[investor] -= ecoins_sold;
        equity_usd[investor] =  equity_ecoins[investor] / 1000;
        total_ecoins_bought -= ecoins_sold;
    }
    
    
}