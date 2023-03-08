pragma solidity ^0.5.0;

import "./BanksyNFT.sol"
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


contract BanksyNFTCrowdSale is Crowdsale, MintedCrowdsale{ 
    
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    constructor(
        uint rate,
        address payable wallet,
        BanksyNFT token
    )
    Crowdsale(rate, wallet, token) public {
        // constructor can stay empty
    }
}


contract BanksyNFTCrowdSaleDeployer {
    // Create an `address public` variable called `kasei_token_address`.
    address public banksy_token_address;
    // Create an `address public` variable called `kasei_crowdsale_address`.
    address public banksy_crowdsale_address;

    // Add the constructor.
    constructor(
       string memory name,
       string memory symbol,
       address payable wallet
    ) 
    public {
        // Create a new instance of the KaseiCoin contract.
        BanksyNFT token = new KaseiCoin(name, symbol, 0);
        
        // Assign the token contract’s address to the `kasei_token_address` variable.
        banksy_token_address = address(token);

        // Create a new instance of the `KaseiCoinCrowdsale` contract
        BanksyNFTCrowdSale banksy_crowdsale = new BanksyNFTCrowdsale(1, wallet, token);

            
        // Aassign the `KaseiCoinCrowdsale` contract’s address to the `kasei_crowdsale_address` variable.
        banksy_crowdsale_address = address(banksy_crowdsale);

        // Set the `KaseiCoinCrowdsale` contract as a minter
        token.addMinter(banksy_crowdsale_address);
        
        // Have the `KaseiCoinCrowdsaleDeployer` renounce its minter role.
        token.renounceMinter();
    }
}