pragma solidity ^0.5.0;

// import all inheritance need for crowdfund and related fungible token deployment

import "./BanksyFR.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


// Get the BanksyNFTCrowdsale contract to inherit the above OpenZeppelin:

contract BanksyNFTCrowdsale is Crowdsale, MintedCrowdsale{
    
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    constructor(
        uint rate,
        address payable wallet,
        BanksyFR token
    )
    Crowdsale(rate, wallet, token) public {
        // constructor can stay empty
    }
}


contract BanksyNFTCrowdSaleDeployer {
    // Create a public token address
    address public banksy_token_address;
    // Create a public address variable for the token
    address public banksy_crowdsale_address;

    // Add the constructor
    constructor(
       string memory name,
       string memory symbol,
       address payable wallet
    ) 
    public {
        // Create a new instance of the BanksyFR contract
        BanksyFR token = new BanksyFR(name, symbol, 0);
        
        // Assign the token's contract address upon transaction
        banksy_token_address = address(token);

        // Create a new instance of the crowdsale contract
        BanksyNFTCrowdsale banksy_crowdsale = new BanksyNFTCrowdsale(1, wallet, token);

            
        // Assign the crowdsale contract’s address to the `banksy_crowdsale_address` variable.
        banksy_crowdsale_address = address(banksy_crowdsale);

        // Set the crowdsale contract as a minter
        token.addMinter(banksy_crowdsale_address);
        
        // Have the `BanksyNFTCrowdsaleDeployer` renounce its minter role.
        token.renounceMinter();
    }
}